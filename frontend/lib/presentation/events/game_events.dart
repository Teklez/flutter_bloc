import 'package:equatable/equatable.dart';
import '../../domain/game_model.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object?> get props => [];
}

class FetchGames extends GameEvent{
  const FetchGames();
  
}

class AddGame extends GameEvent {
  final Game game;

  const AddGame(this.game);

  @override
  List<Object?> get props => [game];
}

class EditGame extends GameEvent {
  final Game game;

  const EditGame(this.game);

  @override
  List<Object?> get props => [game];
}

class DeleteGame extends GameEvent {
  final String gameId;

  const DeleteGame(this.gameId);

  @override
  List<Object?> get props => [gameId];
}
