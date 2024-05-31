import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/application/game/game_bloc.dart';
import 'package:frontend/presentation/events/game_events.dart';
import 'package:frontend/presentation/states/game_states.dart';
import 'package:frontend/presentation/widgets/custom_card.dart';
import 'package:frontend/presentation/widgets/drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GameBloc gameBloc = BlocProvider.of<GameBloc>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      gameBloc.add(const FetchGames());
    });
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
        ],
        title: const Text(
          "BetEbet",
        ),
      ),
      drawer: const MenuDrawer(
        menuItems: [
          ["Home", "/"],
          ["Profile", "/profile"],
          ["About", "/about"],
          ["Logout", "/login"],
        ],
      ),
      body: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          if (state is GameEmpty) {
            return const Center(child: Text("No games found"));
          } else if (state is GameLoadSuccess) {
            return GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16.0),
              childAspectRatio: 8.0 / 10.0,
              children: state.games.map((game) {
                return GameCard(
                  game: game,
                );
              }).toList(),
            );
          } else if (state is GameError) {
            return const Center(child: Text("Error loading games"));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
