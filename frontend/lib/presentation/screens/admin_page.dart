import 'package:flutter/material.dart';
import 'package:frontend/model/game.dart';
import 'package:frontend/presentation/widgets/custom_card.dart';

import 'package:frontend/presentation/widgets/drawer.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 211, 47, 47),
        title: const Text("BetEbet"),
      ),
      drawer: const MenuDrawer(menuItems: [
        ["Home", "/admin"],
        ["Users", "/users"],
        ["Add Game", "/add_game"],
        ["Logout", "/login"]
      ]),
      body: GridView.count(
        crossAxisCount: 1,
        padding: const EdgeInsets.all(40.0),
        childAspectRatio: 8.0 / 10.0,
        children: const <Widget>[
          AGameCard(
            game: Game(
              name: "Poker",
              image: "assets/game1.jpg",
              rating: 4.5,
              publisher: "publisher: NIC private Inc.",
              releaseDate: "2021-10-10",
            ),
          ),
          AGameCard(
            game: Game(
              name: "Russian Roulette",
              image: "assets/game4.jpg",
              rating: 4.5,
              publisher: "publisher: NIC private Inc.",
              releaseDate: "2021-10-10",
            ),
          ),
          AGameCard(
            game: Game(
              name: "Blackjack",
              image: "assets/game3.jpg",
              rating: 4.5,
              publisher: "publisher: NIC private Inc.",
              releaseDate: "2021-10-10",
            ),
          ),
          AGameCard(
            game: Game(
              name: "Slot Machine",
              image: "assets/game2.jpg",
              rating: 4.5,
              publisher: "publisher: NIC private Inc.",
              releaseDate: "2021-10-10",
            ),
          ),
          AGameCard(
            game: Game(
              name: "Roulette",
              image: "assets/game5.jpg",
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
