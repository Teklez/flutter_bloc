import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/game/game_events.dart';
import 'package:frontend/game/game_model.dart';
import 'package:frontend/game/game_states.dart';

import 'game_repository.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameRepository gameRepository;

  GameBloc(this.gameRepository) : super(GameInitial()) {
    // Register event handlers
    on<FetchGames>(_handleFetchGames);
    on<AddGame>(_handleAddGame);
    on<EditGame>(_handleEditGame);
    on<DeleteGame>(_handleDeleteGame);
  }

  void _handleFetchGames(FetchGames event, Emitter<GameState> emit) async {
    try {
      final List<Game> games = await gameRepository.fetchGames();
      // print("Games: $games ");
      if (games.isEmpty) {
        emit(GameEmpty());
        return;
      } else {
        emit(GameLoadSuccess(games));
      }
    } catch (e) {
      print(e.toString());
      emit(GameError());
    }
  }

  void _handleAddGame(AddGame event, Emitter<GameState> emit) async {
    try {
      await gameRepository.addGame(event.game);
      final List<Game> games = await gameRepository.fetchGames();
      emit(GameLoadSuccess(games));
    } catch (e) {
      emit(GameError());
    }
  }

  void _handleEditGame(EditGame event, Emitter<GameState> emit) async {
    try {
      await gameRepository.editGame(event.game);
      final List<Game> games = await gameRepository.fetchGames();
      emit(GameLoadSuccess(games));
    } catch (e) {
      emit(GameError());
    }
  }

  void _handleDeleteGame(DeleteGame event, Emitter<GameState> emit) async {
    try {
      await gameRepository.deleteGame(event.gameId);
      final List<Game> games = await gameRepository.fetchGames();
      emit(GameLoadSuccess(games));
    } catch (e) {
      emit(GameError());
    }
  }
}
