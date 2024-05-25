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
import {Request} from 'express';
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
  @Public()
  @Get('users')
  async getUsers(): Promise<User[]> {
    return this.authService.getUsers();
  }

  @Public()
  @Get('user/:id')
  async getUser(@Param('id') id: string): Promise<User> {
    const objectId = new ObjectId(id);
    return this.authService.getUser(objectId);
  }

  @Public()
  @Put('update/:id')
  async updateUser(
    @Param('id') id: string,
    @Body() userDto: LoginDto,
  ): Promise<User> {
    const objectId = new ObjectId(id);
    return this.authService.updateUser(objectId, userDto);
  }
  @Public()
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
