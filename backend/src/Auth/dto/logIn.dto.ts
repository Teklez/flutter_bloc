import {IsNotEmpty, IsString, MinLength } from 'class-validator';
import { Role } from '../enums/role.enum';

export class LoginDto {
  @IsNotEmpty()
  @IsString()
  username: string;

  @IsNotEmpty()
  @IsString()
  @MinLength(6)
  password: string;

  // Add status field with default value of 'unblocked'
  status: string = 'unblocked';

  // Add role field with default value of 'user'
  roles: Role[] = [Role.User];
}
