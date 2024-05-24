import 'package:flutter/material.dart';
import 'package:frontend/model/game.dart';
import 'package:frontend/presentation/widgets/custom_card.dart';

class GameDetailPage extends StatelessWidget {
  const GameDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const GameDetail(
        game: Game(
          name: "Russian Roulette",
          image: "assets/game4.jpg",
          publisher: "New Youk Times Best seller",
          description: "hell of a game",
          releaseDate: "2021-10-10",
        ),
      ),
    );
  }
}
