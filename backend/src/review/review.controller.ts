import {
  Controller,
  Get,
  Post,
  Put,
  Delete,
  Param,
  Body,
} from '@nestjs/common';
import { ReviewService } from './review.service';
import { ReviewDto } from './review.dto';
import { Review } from './review.schema';
import { Public } from 'src/Auth/decorator/public.decorator';
import { ObjectId } from 'mongodb';

@Controller('reviews')
export class ReviewController {
  constructor(private readonly reviewService: ReviewService) {}
  @Public()
  @Get('/game/:gameId')
  async getReviews(@Param('gameId') gameId: string): Promise<Review[]> {
    return this.reviewService.getReviews(gameId);
  }
  @Public()
  @Post('/game/:gameId')
  async createReview(
    @Body() reviewDto: ReviewDto,
    @Param('gameId') gameId: string,
  ): Promise<Review> {
    return this.reviewService.createReview(reviewDto, gameId);
  }

  @Public()
  @Get(':id')
  async getReview(@Param('id') id: string): Promise<Review> {
    return this.reviewService.getReview(id);
  }

  @Public()
  @Put('update/:id')
  async updateReview(
    @Param('id') id: string,
    @Body() reviewDto: ReviewDto,
  ): Promise<Review> {
    return this.reviewService.updateReview(id, reviewDto);
  }

  @Public()
  @Delete('delete/:id')
  async deleteReview(
    @Param('id') id: string,
    @Body('gameId') gameId: string,
  ): Promise<Review> {
    return this.reviewService.deleteReview(id, gameId);
  }
}
