import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import * as mongoose from 'mongoose';

@Schema({
  timestamps: true,
})
export class Game {
  @Prop({ required: true })
  name: string;
  @Prop({ unique: true })
  description: string;
  @Prop()
  publisher: string;
  @Prop()
  releaseDate: string;
  reviews: [{ type: mongoose.Schema.Types.ObjectId; ref: 'Review' }];
  @Prop()
  imageUrl: string;

}

export const GameSchema = SchemaFactory.createForClass(Game);
