import 'package:flutter/material.dart';
import 'package:frontend/model/game.dart';
import 'package:frontend/presentation/screens/game_detail.dart';
import 'package:frontend/presentation/widgets/dialogues.dart';
//============================================================================== USER GAME CARD =================================================================

class GameCard extends StatelessWidget {
  final Game game;
  const GameCard({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 18 / 14,
            child: Image.asset(
              game.image,
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
                      const Text(
                        '4.5',
                        // style: theme.textTheme.labelSmall,
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const GameDetailPage()),
                          );
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
              game.image,
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
                      const EditDeleteDialogue(
                        route: "/add_game",
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
        clipBehavior: Clip.antiAlias,
        elevation: 0.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 14,
              child: Image.asset(
                game.image,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 5.0),
              child: Column(
                children: <Widget>[
                  Text(
                    game.name,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    game.description,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    game.publisher,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    game.releaseDate,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      print("betted");
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(
                              255, 207, 75, 91)), // Set background color
                      foregroundColor: MaterialStateProperty.all(
                          Colors.white), // Set text color
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10)), // Set padding
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ), // Set rounded corners
                    ),
                    child: const Text("Bet"),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("See review"),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/review");
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
