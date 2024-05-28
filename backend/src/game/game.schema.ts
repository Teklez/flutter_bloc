import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import * as mongoose from 'mongoose';
import { Document } from 'mongoose';

@Schema({
  timestamps: true,
})
export class Game extends Document {
  @Prop({ required: true })
  name: string;

  @Prop({ unique: true })
  description: string;

  @Prop()
  publisher: string;

  @Prop()
  releaseDate: string;

  @Prop([{ type: mongoose.Schema.Types.ObjectId, ref: 'Review' }])
  reviews: mongoose.Types.ObjectId[];

  @Prop()
  image: string;
}

export const GameSchema = SchemaFactory.createForClass(Game);
