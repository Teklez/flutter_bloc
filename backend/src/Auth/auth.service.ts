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

    const isPasswordValid = await bcrypt.compare(
      loginDto.password,
      user.password,
    );

    if (!isPasswordValid) {
      console.log('incorrect password');
      throw new HttpException('incorrectPassword', HttpStatus.UNAUTHORIZED);
    }
    console.log('logging in user', user);
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
    console.log(loginDto.password);
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(loginDto.password, salt);
    loginDto.password = hashedPassword;
    const user = new this.userModel(loginDto);
    return await user.save();
  }

  // update user
  async updateUser(id: ObjectId, user: LoginDto): Promise<User> {
    const newPassword = await bcrypt.hash(user.password, 10);
    user.password = newPassword;
    const updatedUser = await this.userModel.findByIdAndUpdate(id, user, {
      new: true,
    });
    return updatedUser;
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
