import {
  HttpException,
  HttpStatus,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Game } from './game.schema';
import { GameDto } from './game.dto';
import { ObjectId } from 'mongodb';
import { Review } from 'src/review/review.schema';

@Injectable()
export class GameService {
  constructor(
    @InjectModel(Game.name)
    private gameModel: Model<Game>,
    @InjectModel('Review')
    private reviewModel: Model<Review>,
  ) {}

  async getGames(): Promise<Game[]> {
    const games = await this.gameModel.find().sort({ createdAt: -1 }).exec();
    return games;
  }

  async createGame(gameDto: GameDto): Promise<Game> {
    const game = new this.gameModel(gameDto);
    return await game.save();
  }

  async getGame(id: string): Promise<Game> {
    const game = await this.gameModel.findById(id);
    if (!game) {
      throw new NotFoundException('Game not found');
    }
    return game;
  }

  async updateGame(id: string, gameDto: GameDto): Promise<Game> {
    const game = await this.gameModel.findById(id);
    if (!game) {
      throw new NotFoundException('Game not found');
    }
    game.image = gameDto.image;
    game.name = gameDto.name;
    game.description = gameDto.description;
    game.publisher = gameDto.publisher;
    game.releaseDate = gameDto.releaseDate;
    await game.save();

    return game;
  }

  async deleteGame(id: ObjectId): Promise<Game> {
    const game = await this.gameModel.findById(id);
    if (!game) {
      throw new NotFoundException('Game not found');
    }
    const reviews = game.reviews;
    for (let reviewId of reviews) {
      await this.reviewModel.findByIdAndDelete(reviewId);
    }

    return await this.gameModel.findByIdAndDelete(id);
  }
}
