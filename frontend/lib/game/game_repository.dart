import 'package:frontend/game/game_model.dart';
import 'package:frontend/game/game_service.dart';

class GameRepository {
  final GameService gameService;

  GameRepository(this.gameService);

  Future<List<Game>> fetchGames() async {
    try {
      return await gameService.fetchGames();
    } catch (e) {
      // Print detailed error information
      print('Error fetching games: $e');
      // Optionally rethrow the error to propagate it upwards
      rethrow;
    }
  }

  Future<void> addGame(Game game) async {
    try {
      await gameService.addGame(game);
    } catch (e) {
      // Print detailed error information
      print('Error adding game: $e');
      // Optionally rethrow the error to propagate it upwards
      rethrow;
    }
  }

  Future<void> editGame(Game game) async {
    try {
      await gameService.editGame(game);
    } catch (e) {
      // Print detailed error information
      print('Error editing game: $e');
      // Optionally rethrow the error to propagate it upwards
      rethrow;
    }
  }

  Future<void> deleteGame(String gameId) async {
    try {
      await gameService.deleteGame(gameId);
    } catch (e) {
      // Print detailed error information
      print('Error deleting game: $e');
      // Optionally rethrow the error to propagate it upwards
      rethrow;
    }
  }
}
