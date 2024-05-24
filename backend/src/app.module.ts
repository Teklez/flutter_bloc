import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';

import { ConfigModule } from '@nestjs/config';
import { MongooseModule } from '@nestjs/mongoose';

import { JwtService } from '@nestjs/jwt';
import { PassportModule } from '@nestjs/passport';

import { AuthMiddleware } from './Auth/auth.middleware';
import { AuthModule } from './Auth/auth.module';
import { AuthController } from './Auth/auth.controller';
import { AuthService } from './Auth/auth.service';
import { GameSchema } from './game/game.schema';
import { Review, ReviewSchema } from './review/review.schema';
import { GameModule } from './game/game.module';
import { ReviewModule } from './review/review.module';
import { GameController } from './game/game.controller';
import { ReviewController } from './review/review.controller';
import { GameService } from './game/game.service';
import { ReviewService } from './review/review.service';
import { UserSchema } from './Auth/schemas/user.schema';

@Module({
  imports: [
    ConfigModule.forRoot({
      envFilePath: '.env',
      isGlobal: true,
    }),
    PassportModule.register({ session: true }),
    MongooseModule.forRoot(process.env.DB_URI),
    MongooseModule.forFeature([
      { name: 'User', schema: UserSchema },
      { name: 'Game', schema: GameSchema },
      { name: 'Review', schema: ReviewSchema },
    ]),

    AuthModule,
    GameModule,
    ReviewModule,
  ],
  controllers: [
    AppController,

    AuthController,
    GameController,
    ReviewController,
  ],
  providers: [AppService, AuthService, JwtService, GameService, ReviewService],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer.apply(AuthMiddleware).forRoutes('*');
  }
}
