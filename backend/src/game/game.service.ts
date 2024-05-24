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

@Injectable()
export class GameService {
  constructor(
    @InjectModel(Game.name)
    private gameModel: Model<Game>,
  ) {}

  async getGames(): Promise<Game[]> {
    const games = await this.gameModel.find();
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
    game.name = gameDto.name;
    game.description = gameDto.description;
    game.publisher = gameDto.publisher;
    game.releaseDate = gameDto.releaseDate;
    return await game.save();
  }

  async deleteGame(id: ObjectId): Promise<Game> {
    const game = await this.gameModel.findById(id);
    if (!game) {
      throw new NotFoundException('Game not found');
    }
    return await this.gameModel.findByIdAndDelete(id);
  }
}
