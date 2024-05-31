import {
  Controller,
  Get,
  Post,
  Put,
  Delete,
  Param,
  Body,
} from '@nestjs/common';
import { GameService } from './game.service';
import { GameDto } from './game.dto';
import { Game } from './game.schema';
import { Public } from 'src/Auth/decorator/public.decorator';
import { ObjectId } from 'mongodb';
import { Role } from 'src/Auth/enums/role.enum';
import { Roles } from 'src/Auth/decorator/roels.decorator';
@Controller('games')
export class GameController {
  constructor(private readonly gameService: GameService) {}

  @Get()
  async getGames(): Promise<Game[]> {
    return this.gameService.getGames();
  }

  // @Roles(Role.Admin)
  @Roles(Role.Admin)
  @Post('/add')
  async createGame(@Body() gameDto: GameDto): Promise<Game> {
    return this.gameService.createGame(gameDto);
  }

  @Get(':id')
  async getGame(@Param('id') id: string): Promise<Game> {
    return this.gameService.getGame(id);
  }
  // @Roles(Role.Admin)
  @Roles(Role.Admin)
  @Put('update/:id')
  async updateGame(
    @Param('id') id: string,
    @Body() gameDto: GameDto,
  ): Promise<Game> {
    return this.gameService.updateGame(id, gameDto);
  }
  @Roles(Role.Admin)
  @Delete('delete/:id')
  async deleteGame(@Param('id') id: string): Promise<Game> {
    const objectId = new ObjectId(id);
    return this.gameService.deleteGame(objectId);
  }
}
