import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import mongoose from 'mongoose';

@Schema({
  timestamps: true,
})
export class Review {
  @Prop({ unique: true })
  comment: string;
  @Prop()
  rating: number;
  @Prop()
  date: string;
  game: { type: mongoose.Schema.Types.ObjectId; ref: 'Game' };
  user: { type: mongoose.Schema.Types.ObjectId; ref: 'User' };
}

export const ReviewSchema = SchemaFactory.createForClass(Review);
