import {
  Controller,
  Post,
  Body,
  Param,
  Put,
  Delete,
  Get,
  Req,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { LoginDto } from './dto/logIn.dto';
import { User } from './schemas/user.schema';
import { Public } from './decorator/public.decorator';
import { ObjectId } from 'mongodb';
import { Role } from './enums/role.enum';
import { RolesGuard } from './guards/roles.guard';
import { Roles } from './decorator/roels.decorator';
import { Request } from 'express';
import { userInfo } from 'os';
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Public()
  @Post('signup')
  async signUp(@Body() loginDto: LoginDto): Promise<User> {
    return this.authService.signUp(loginDto);
  }
  @Public()
  @Post('login')
  async logIn(@Body() loginDto: LoginDto): Promise<any> {
    return this.authService.logIn(loginDto);
  }

  // @Roles(Role.Admin)

  @Get('users')
  async getUsers(): Promise<User[]> {
    return this.authService.getUsers();
  }

  @Get('user/:id')
  async getUser(@Param('id') id: string): Promise<User> {
    const objectId = new ObjectId(id);
    return this.authService.getUser(objectId);
  }

  @Roles(Role.Admin)
  @Put('update/:id')
  async userInfoUpdate(
    @Param('id') id: string,
    @Body() loginDto,
  ): Promise<User> {
    const objectId = new ObjectId(id);
    return this.authService.userInfoUpdate(objectId, loginDto);
  }

  @Put('user/update/:id')
  async updateUser(@Param('id') id: string, @Body() updatedata): Promise<User> {
    const objectId = new ObjectId(id);

    return this.authService.updateUser(
      objectId,
      updatedata.oldPassword,
      updatedata.newPassword,
      updatedata.username,
    );
  }

  @Delete('delete/:id')
  async deleteUser(@Param('id') id: string): Promise<User> {
    console.log('id', id);
    const objectId = new ObjectId(id);
    return this.authService.deleteUser(objectId);
  }

  @Get('/logout')
  async logOut(@Req() req: Request): Promise<any> {
    return this.authService.logout(req);
  }
}
