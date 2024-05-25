import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import * as mongoose from 'mongoose';
import { Role } from '../enums/role.enum';

@Schema({
  timestamps: true,
})
export class User extends mongoose.Document {
  @Prop({ required: true, unique: true })
  username: string;
  @Prop()
  password: string;

  // Add status field with default value of 'unblocked'
  @Prop({ default: 'unblocked' })
  status: string;

  // Add role field with default value of 'user'
  @Prop({ default: [Role.User] })
  roles: Role[];
}

export const UserSchema = SchemaFactory.createForClass(User);
