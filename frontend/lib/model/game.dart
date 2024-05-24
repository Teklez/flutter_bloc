class Game {
  final String name;
  final String description;
  final double rating;
  final String image;
  final String publisher;
  final String releaseDate;

  const Game({
    required this.name,
    this.rating = 0.0,
    required this.image,
    this.description = "",
    this.publisher = "",
    this.releaseDate = "",
  });
}
