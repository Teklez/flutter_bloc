import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import mongoose from 'mongoose';

@Schema({
  timestamps: true,
})
export class Review {
  @Prop()
  comment: string;
  @Prop()
  rating: number;
  @Prop()
  date: string;
  @Prop({ default: 'Anonymous' })
  username: string;
}

export const ReviewSchema = SchemaFactory.createForClass(Review);
