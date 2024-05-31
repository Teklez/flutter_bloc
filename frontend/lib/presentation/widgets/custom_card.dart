import 'package:flutter/material.dart';
import 'package:frontend/domain/game_model.dart';
import 'package:frontend/presentation/widgets/dialogues.dart';
import 'package:go_router/go_router.dart';
//============================================================================== USER GAME CARD =================================================================

class GameCard extends StatelessWidget {
  final Game game;
  const GameCard({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Colors.black12,
      clipBehavior: Clip.antiAlias,
      elevation: 0.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 18 / 14,
            child: Image.asset(
              'assets/${game.image}.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    game.name,
                    // style: theme.textTheme.labelLarge,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 1.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 16.0,
                        color: Colors.yellow,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        game.rating.toStringAsFixed(1),
                        // style: theme.textTheme.labelSmall,
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      IconButton(
                        onPressed: () {
                          context.push('/game-detail', extra: {'game': game});
                        },
                        icon: const Icon(
                          Icons.details_rounded,
                          color: Colors.white,
                          semanticLabel: "details",
                          size: 20,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//============================================================================== ADMIN GAME CARD =================================================================

class AGameCard extends StatelessWidget {
  final Game game;
  const AGameCard({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 18 / 14,
            child: Image.asset(
              'assets/${game.image}.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    game.name,
                    // style: theme.textTheme.labelLarge,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    game.publisher,
                    // style: theme.textTheme.labelLarge,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        game.releaseDate,
                        // style: theme.textTheme.labelLarge,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      EditDeleteDialogue(
                        data: game,
                        route: "/add_game",
                        feature: "game",
                      ),
                    ],
                  ),
                  const SizedBox(height: 1.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//==============================================================================  GAME DETAIL CARD =================================================================

class GameDetail extends StatelessWidget {
  final game;
  const GameDetail({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        color: Colors.black12,
        clipBehavior: Clip.antiAlias,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 14,
              child: Image.asset(
                'assets/${game.image}.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
              child: Column(
                children: <Widget>[
                  Text(
                    game.name,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    game.description,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[700],
                    ),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    game.publisher,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontStyle: FontStyle.italic,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    game.releaseDate,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[600],
                    ),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      print("betted");
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          const Color.fromARGB(
                              255, 207, 75, 91)), // Set background color
                      foregroundColor: WidgetStateProperty.all(
                          Colors.white), // Set text color
                      padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10)), // Set padding
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ), // Set rounded corners
                    ),
                    child: const Text("Bet"),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "See review",
                        style: TextStyle(
                          fontSize: 16.0,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context.push('/review', extra: {'gameId': game.id});
                        },
                        icon: const Icon(Icons.arrow_forward),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
