import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/game/game_bloc.dart';
import 'package:frontend/game/game_events.dart';
import 'package:frontend/game/game_states.dart';

import 'package:frontend/presentation/widgets/custom_card.dart';
import 'package:frontend/presentation/widgets/drawer.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GameBloc gameBloc = BlocProvider.of<GameBloc>(context);

    // Trigger fetching games when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      gameBloc.add(const FetchGames());
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 211, 47, 47),
        title: const Text("BetEbet"),
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
        ],
      ),
      drawer: const MenuDrawer(
        menuItems: [
          ["Home", "/admin"],
          ["Users", "/users"],
          ["Profile", "/profile"],
          ["Add Game", "/add_game"],
          ["Logout", "/login"]
        ],
      ),
      body: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          if (state is GameEmpty) {
            return const Center(child: Text("No games found"));
          } else if (state is GameLoadSuccess) {
            return GridView.count(
              crossAxisCount: 1,
              padding: const EdgeInsets.all(20.0),
              childAspectRatio: 8.0 / 10.0,
              children: state.games.map((game) {
                return AGameCard(
                  game: game,
                );
              }).toList(),
            );
          } else if (state is GameError) {
            return const Center(child: Icon(Icons.error));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
