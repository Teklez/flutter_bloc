import { Injectable, NotFoundException } from '@nestjs/common';
import { Review } from './review.schema';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';

import { ReviewDto } from './review.dto';

import { Game } from 'src/game/game.schema';
import { User } from 'src/Auth/schemas/user.schema';
import { ObjectId } from 'mongodb';

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

  async getReviews(gameId): Promise<Review[]> {
    console.log(`fetching reviews  for game with gameId:${gameId}`);

    const id = new ObjectId(gameId);
    const game = await this.gameModel.findById(id);
    // collect review Ids associated with the given game
    const gameReviews = game.reviews;
    let reviews = [];
    for (let rid of gameReviews) {
      let review = await this.reviewModel.findById(rid);
      reviews.push(review);
    }
    // console.log(`fetched reviews are ${reviews}`);

    return reviews;
  }

  async createReview(reviewDto: ReviewDto, gameId: string): Promise<Review> {
    const id = new ObjectId(gameId);
    const game = await this.gameModel.findById(id);
    const review = new this.reviewModel(reviewDto);
    const newReview = await review.save();
    console.log(`=====================>${newReview.comment}`);
    console.log(`=====================>${reviewDto.comment}`);
    game.reviews.push(newReview._id);
    game.save();

    return review;
  }

  async getReview(id: string): Promise<Review> {
    const review = await this.reviewModel.findById(id);
    if (!review) {
      throw new NotFoundException('Review not found');
    }
    return review;
  }

  async updateReview(id: string, reviewDto: ReviewDto): Promise<Review> {
    console.log(
      `================================================>updating review with id:${id}`,
    );
    const id_o = new ObjectId(id);
    const review = await this.reviewModel.findById(id_o);
    if (!review) {
      throw new NotFoundException('Review not found');
    }

    review.comment = reviewDto.comment;
    review.rating = reviewDto.rating;
    return await review.save();
  }

  async deleteReview(id: string, gameId: string): Promise<Review> {
    console.log(
      `================================================>deleting review with id:${id}`,
    );

    const gameId_o = new ObjectId(gameId);
    const id_o = new ObjectId(id);

    const game = await this.gameModel.findById(gameId_o);

    if (!game) {
      throw new NotFoundException('Game not found');
    }

    const reviews = game.reviews;
    const filtered = [];
    for (let reviewId of reviews) {
      if (reviewId.toString() != id_o.toString()) {
        filtered.push(reviewId);
      }
    }
    game.reviews = filtered;

    await game.save();

    const review = await this.reviewModel.findById(id_o);

    if (!review) {
      throw new NotFoundException('Review not found');
    }

    await this.reviewModel.findByIdAndDelete(id_o);

    return review;
  }
}
