import 'package:flutter/material.dart';
import 'package:frontend/presentation/widgets/custom_card.dart';
import 'package:frontend/model/game.dart';
import 'package:frontend/presentation/widgets/dialogues.dart';

import 'package:frontend/presentation/widgets/drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 211, 47, 47),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              semanticLabel: 'search',
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
          const Filter(),
        ],
        title: const Text(
          "BetEbet",
        ),
      ),
      drawer: const MenuDrawer(
        menuItems: [
          ["Home", "/"],
          ["About", "/about"],
          ["Logout", "/login"],
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16.0),
        childAspectRatio: 8.0 / 10.0,
        children: const <Widget>[
          GameCard(
            game: Game(
              name: "Poker",
              image: "assets/game4.jpg",
              rating: 4.5,
              publisher: "publisher: NIC private Inc.",
              releaseDate: "2021-10-10",
            ),
          ),
          GameCard(
            game: Game(
              name: "Russian Roulette",
              image: "assets/game3.jpg",
              rating: 4.5,
              publisher: "publisher: NIC private Inc.",
              releaseDate: "2021-10-10",
            ),
          ),
          GameCard(
            game: Game(
              name: "Blackjack",
              image: "assets/game2.jpg",
              rating: 4.5,
              publisher: "publisher: NIC private Inc.",
              releaseDate: "2021-10-10",
            ),
          ),
          GameCard(
            game: Game(
              name: "Slot Machine",
              image: "assets/game5.jpg",
              rating: 4.5,
              publisher: "publisher: NIC private Inc.",
              releaseDate: "2021-10-10",
            ),
          ),
          GameCard(
            game: Game(
              name: "Roulette",
              image: "assets/game1.jpg",
              rating: 4.5,
              publisher: "publisher: NIC private Inc.",
              releaseDate: "2021-10-10",
            ),
          ),
          GameCard(
            game: Game(
              name: "Blackjack",
              image: "assets/game6.jpg",
              rating: 4.5,
              publisher: "publisher: NIC private Inc.",
              releaseDate: "2021-10-10",
            ),
          ),
          GameCard(
            game: Game(
              name: "Slot Machine",
              image: "assets/game7.jpg",
              rating: 4.5,
              publisher: "publisher: NIC private Inc.",
              releaseDate: "2021-10-10",
            ),
          ),
          GameCard(
            game: Game(
              name: "Roulette",
              image: "assets/game8.jpg",
              rating: 4.5,
              publisher: "publisher: NIC private Inc.",
              releaseDate: "2021-10-10",
            ),
          ),
          GameCard(
            game: Game(
              name: "Poker",
              image: "assets/game9.jpg",
              rating: 4.5,
              publisher: "publisher: NIC private Inc.",
              releaseDate: "2021-10-10",
            ),
          ),
          GameCard(
            game: Game(
              name: "Russian Roulette",
              image: "assets/game10.jpg",
              rating: 4.5,
              publisher: "publisher: NIC private Inc.",
              releaseDate: "2021-10-10",
            ),
          ),
          GameCard(
            game: Game(
              name: "Blackjack",
              image: "assets/game11.jpg",
              rating: 4.5,
              publisher: "publisher: NIC private Inc.",
              releaseDate: "2021-10-10",
            ),
          ),
        ],
      ),
    );
  }
}
