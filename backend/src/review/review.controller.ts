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

@Controller('reviews')
export class ReviewController {
  constructor(private readonly reviewService: ReviewService) {}

  @Get()
  async getReviews(): Promise<Review[]> {
    return this.reviewService.getReviews();
  }
  @Public()
  @Post()
  async createReview(@Body() reviewDto: ReviewDto): Promise<Review> {
    return this.reviewService.createReview(reviewDto);
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
  async deleteReview(@Param('id') id: string): Promise<Review> {
    return this.reviewService.deleteReview(id);
  }
}
