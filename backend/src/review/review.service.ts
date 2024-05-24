import { Injectable, NotFoundException } from '@nestjs/common';
import { Review } from './review.schema';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';

import { ReviewDto } from './review.dto';

import { Game } from 'src/game/game.schema';
import { User } from 'src/Auth/schemas/user.schema';

@Injectable()
export class ReviewService {
  constructor(
    @InjectModel(Review.name)
    private reviewModel: Model<Review>,
    @InjectModel(User.name)
    private userModel: Model<User>,
    @InjectModel(Game.name)
    private gameModel: Model<Game>,
  ) {}

  async getReviews(): Promise<Review[]> {
    const reviews = await this.reviewModel.find();
    return reviews;
  }

  async createReview(reviewDto: ReviewDto): Promise<Review> {
    const review = new this.reviewModel(reviewDto);
    return await review.save();
  }

  async getReview(id: string): Promise<Review> {
    const review = await this.reviewModel.findById(id);
    if (!review) {
      throw new NotFoundException('Review not found');
    }
    return review;
  }

  async updateReview(id: string, reviewDto: ReviewDto): Promise<Review> {
    const review = await this.reviewModel.findById(id);
    if (!review) {
      throw new NotFoundException('Review not found');
    }

    review.comment = reviewDto.comment;
    review.rating = reviewDto.rating;
    review.date = reviewDto.date;

    return await review.save();
  }

  async deleteReview(id: string): Promise<Review> {
    const review = await this.reviewModel.findById(id);
    if (!review) {
      throw new NotFoundException('Review not found');
    }
    return await this.reviewModel.findByIdAndDelete(id);
  }
}
