import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/game/game_bloc.dart';
import 'package:frontend/game/game_events.dart';
import 'package:frontend/game/game_model.dart';
import 'package:frontend/game/game_states.dart';
import 'package:frontend/presentation/screens/game_detail.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Game> _filteredGames = [];
  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    context.read<GameBloc>().add(FetchGames());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _hasSearched = query.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            DecoratedBox(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromARGB(255, 164, 160, 160),
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4.0, 0.0, 0.0, 0.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'Search...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: BlocBuilder<GameBloc, GameState>(
                builder: (context, state) {
                  if (state is GameLoadSuccess) {
                    final games = state.games;
                    _filteredGames = games.where((game) {
                      final query = _searchController.text.toLowerCase();
                      return game.name.toLowerCase().contains(query);
                    }).toList();

                    if (!_hasSearched) {
                      return const Center(
                          child: Text('No games to display. Please search.'));
                    }

                    if (_filteredGames.isEmpty) {
                      return const Center(
                          child: Text('No games match your search.'));
                    }

                    return ListView.builder(
                      itemCount: _filteredGames.length,
                      itemBuilder: (context, index) => _buildSearchResultTile(
                          _filteredGames[index], context),
                    );
                  } else if (state is GameError) {
                    return Center(child: Text('Failed to load games'));
                  } else {
                    return const Center(child: Text('No games available'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResultTile(Game game, BuildContext context) {
    return ListTile(
      leading: Container(
        width: 100,
        height: 100,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            image: AssetImage(game.image),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(game.name),
      subtitle: Text(game.publisher),
      trailing: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "4.5", 
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          Icon(
            Icons.star,
            color: Colors.yellow,
          ),
        ],
      ),
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => GameDetailPage(game: game),
        );
        Navigator.push(context, route);
      },
    );
  }
}
