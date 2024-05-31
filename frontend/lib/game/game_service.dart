import 'dart:convert';
import 'package:frontend/game/game_model.dart';
import 'package:http/http.dart' as http;

class GameService {
  static const baseUrl = 'http://127.0.0.1:5500';

  Future<List<Game>> fetchGames() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/games'));
      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        return list.map((model) => Game.fromJson(model)).toList();
      } else {
        throw Exception('Failed to load games: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load games: $e');
    }
  }

  Future<void> addGame(Game game) async {
    final response = await http.post(
      Uri.parse("$baseUrl/games/add"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(game.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add game');
    }
  }

  Future<void> editGame(Game game) async {
    final response = await http.put(
      Uri.parse('$baseUrl/games/update/${game.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(game.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to edit game');
    }
  }

  Future<void> deleteGame(String gameId) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/games/delete/$gameId'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete game');
    }
  }
}
