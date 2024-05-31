import 'package:flutter/material.dart';
import 'package:frontend/domain/game_model.dart';
import 'package:frontend/presentation/widgets/custom_card.dart';

class GameDetailPage extends StatelessWidget {
  final Game game;
  const GameDetailPage({super.key, required this.game});

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
      body: GameDetail(game: game),
    );
  }
}
