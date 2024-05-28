import {
  HttpException,
  HttpStatus,
  Injectable,
  Req,
  UnauthorizedException,
} from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { User } from './schemas/user.schema';
import * as bcrypt from 'bcryptjs';
import { JwtService } from '@nestjs/jwt';
import { LoginDto } from './dto/logIn.dto';
import { ObjectId } from 'mongodb';
import { Request } from 'express';

@Injectable()
export class AuthService {
  constructor(
    @InjectModel(User.name)
    private userModel: Model<User>,
    private jwtService: JwtService,
  ) {}

  async findByUsername(username: string): Promise<User | null> {
    return await this.userModel.findOne({ username }).exec();
  }
  // validate user
  async validateUser(username: string, password: string): Promise<any> {
    const user = await this.findByUsername(username);
    const passwordMatch: boolean = await this.passworMatch(
      password,
      user.password,
    );
    if (!passwordMatch)
      throw new HttpException('Invalid credentials', HttpStatus.BAD_REQUEST);

    return {
      name: user.username,
      roles: user.roles,
    };
  }

  async passworMatch(password: string, hash: string): Promise<boolean> {
    return await bcrypt.compare(password, hash);
  }

  // find user
  async getUser(id: ObjectId): Promise<User> {
    const user = await this.userModel.findById(id).exec();
    return user;
  }

  // find all users
  async getUsers(): Promise<User[]> {
    const users = await this.userModel.find().exec();
    return users;
  }

  // login service

  async logIn(loginDto: LoginDto): Promise<any> {
    const user = await this.userModel
      .findOne({ username: loginDto.username })
      .lean()
      .exec();
    if (!user) {
      console.log('user not found');
      throw new HttpException('userNotFound', HttpStatus.NOT_FOUND);
    }

    if (user.roles[0] == 'admin') {
      var isPasswordValid = user.password == loginDto.password;
    } else {
      isPasswordValid = await bcrypt.compare(loginDto.password, user.password);
    }

    if (!isPasswordValid) {
      console.log('password incorrect');
      throw new HttpException('incorrectPassword', HttpStatus.UNAUTHORIZED);
    }

    const payload = {
      sub: user['_id'],
      username: user.username,
      roles: user.roles,
      status: user.status,
    };

    return {
      access_token: await this.jwtService.signAsync(payload, {
        secret: process.env.JWT_SECRET,
        expiresIn: process.env.JWT_EXPIRES,
      }),
    };
  }

  //   signup service

  async signUp(loginDto: LoginDto): Promise<User> {
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(loginDto.password, salt);
    loginDto.password = hashedPassword;
    let existingUser = await this.userModel
      .findOne({ username: loginDto.username })
      .exec();
    console.log(existingUser);
    if (existingUser != null) {
      throw new HttpException('userExists', HttpStatus.BAD_REQUEST);
    }
    const user = new this.userModel(loginDto);
    return await user.save();
  }

  // update user info

  async userInfoUpdate(id: ObjectId, loginDto: LoginDto): Promise<User> {
    const user = await this.userModel.findById(id).exec();
    user.status = loginDto.status;
    user.roles = loginDto.roles;
    const updatedUser = await user.save();
    return updatedUser;
  }

  // update user
  async updateUser(
    id: ObjectId,
    oldPassword: string,
    newPassword: string,
    newName: string,
  ): Promise<User> {
    const user = await this.userModel.findById(id).exec();

    const isPasswordSame = await this.passworMatch(oldPassword, user.password);
    if (!isPasswordSame) {
      throw new UnauthorizedException('Invalid password');
    }

    // user.username = newName;
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(newPassword, salt);
    user.password = hashedPassword;
    user.username = newName;
    console.log(
      'updating user _________________________________________________-',
    );
    const cu = await user.save();
    const loginDto = new LoginDto();
    loginDto.username = newName;
    loginDto.password = newPassword;
    return await this.logIn(loginDto);
  }

  // delete user
  async deleteUser(id: ObjectId): Promise<User> {
    const deletedUser = await this.userModel.findByIdAndDelete(id);
    return deletedUser;
  }

  async logout(@Req() request: Request): Promise<any> {
    request.session.destroy(() => {
      return {
        message: 'Logout successful',
        statusCode: HttpStatus.OK,
      };
    });
  }
}
