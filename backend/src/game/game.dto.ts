export class GameDto {
  name: string;
  description: string;
  publisher: string;
  releaseDate: string;
  rating: number = 0;
  reviews: string[] = [];
  imageUrl: string;
}
