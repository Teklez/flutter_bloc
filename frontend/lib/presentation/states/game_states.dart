import 'package:equatable/equatable.dart';
import '../../domain/game_model.dart';

abstract class GameState extends Equatable {
  const GameState();

  @override
  List<Object?> get props => [];
}

class GameInitial extends GameState {}

class GameLoadSuccess extends GameState {
  final List<Game> games;

  const GameLoadSuccess(this.games);

  @override
  List<Object?> get props => [games];
}

class GameError extends GameState {}

class GameEmpty extends GameState {}

class GameAdded extends GameState {}

class GameEdited extends GameState {}
