import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/application/game/game_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:frontend/presentation/events/game_events.dart';
import 'package:frontend/presentation/states/game_states.dart';
import 'package:frontend/domain/game_model.dart';
import 'package:frontend/infrastructure/game/game_repository.dart';

import 'game_bloc_test.mocks.dart';

@GenerateMocks([GameRepository])
void main() {
  late GameBloc gameBloc;
  late MockGameRepository mockGameRepository;

  setUp(() {
    mockGameRepository = MockGameRepository();
    gameBloc = GameBloc(mockGameRepository);
  });

  tearDown(() {
    gameBloc.close();
  });

  group('FetchGames', () {
    final List<Game> games = [
      Game(id: '1', name: 'Game 1', image: 'image1.png'),
      Game(id: '2', name: 'Game 2', image: 'image2.png'),
    ];

    blocTest<GameBloc, GameState>(
      'emits [GameLoadSuccess] when fetchGames succeeds with data',
      build: () {
        when(mockGameRepository.fetchGames()).thenAnswer((_) async {
          print('Mock: fetchGames() called');
          return games;
        });
        return gameBloc;
      },
      act: (bloc) {
        print('Act: FetchGames event added');
        bloc.add(const FetchGames());
      },
      expect: () => [
        GameLoadSuccess(games),
      ],
    );

    blocTest<GameBloc, GameState>(
      'emits [GameEmpty] when fetchGames returns empty list',
      build: () {
        when(mockGameRepository.fetchGames()).thenAnswer((_) async {
          print('Mock: fetchGames() called with empty result');
          return [];
        });
        return gameBloc;
      },
      act: (bloc) {
        print('Act: FetchGames event added');
        bloc.add(const FetchGames());
      },
      expect: () => [
        GameEmpty(),
      ],
    );

    blocTest<GameBloc, GameState>(
      'emits [GameError] when fetchGames fails',
      build: () {
        when(mockGameRepository.fetchGames())
            .thenThrow(Exception('Error fetching games'));
        return gameBloc;
      },
      act: (bloc) {
        print('Act: FetchGames event added');
        bloc.add(const FetchGames());
      },
      expect: () => [
        GameError(),
      ],
    );
  });

  group('AddGame', () {
    final Game newGame = Game(id: '3', name: 'Game 3', image: 'image3.png');
    final List<Game> games = [
      Game(id: '1', name: 'Game 1', image: 'image1.png'),
      Game(id: '2', name: 'Game 2', image: 'image2.png'),
      newGame,
    ];

    blocTest<GameBloc, GameState>(
      'emits [GameLoadSuccess, GameAdded] when addGame succeeds',
      build: () {
        when(mockGameRepository.addGame(newGame)).thenAnswer((_) async {
          print('Mock: addGame() called');
        });
        when(mockGameRepository.fetchGames()).thenAnswer((_) async {
          print('Mock: fetchGames() called');
          return games;
        });
        return gameBloc;
      },
      act: (bloc) {
        print('Act: AddGame event added');
        bloc.add(AddGame(newGame));
      },
      expect: () => [
        GameLoadSuccess(games),
        GameAdded(),
      ],
    );

    blocTest<GameBloc, GameState>(
      'emits [GameError] when addGame fails',
      build: () {
        when(mockGameRepository.addGame(newGame))
            .thenThrow(Exception('Error adding game'));
        return gameBloc;
      },
      act: (bloc) {
        print('Act: AddGame event added');
        bloc.add(AddGame(newGame));
      },
      expect: () => [
        GameError(),
      ],
    );
  });

  group('EditGame', () {
    final Game updatedGame =
        Game(id: '1', name: 'Updated Game 1', image: 'image1_updated.png');
    final List<Game> games = [
      updatedGame,
      Game(id: '2', name: 'Game 2', image: 'image2.png'),
    ];

    blocTest<GameBloc, GameState>(
      'emits [GameLoadSuccess, GameEdited] when editGame succeeds',
      build: () {
        when(mockGameRepository.editGame(updatedGame)).thenAnswer((_) async {
          print('Mock: editGame() called');
        });
        when(mockGameRepository.fetchGames()).thenAnswer((_) async {
          print('Mock: fetchGames() called');
          return games;
        });
        return gameBloc;
      },
      act: (bloc) {
        print('Act: EditGame event added');
        bloc.add(EditGame(updatedGame));
      },
      expect: () => [
        GameLoadSuccess(games),
        GameEdited(),
      ],
    );

    blocTest<GameBloc, GameState>(
      'emits [GameError] when editGame fails',
      build: () {
        when(mockGameRepository.editGame(updatedGame))
            .thenThrow(Exception('Error editing game'));
        return gameBloc;
      },
      act: (bloc) {
        print('Act: EditGame event added');
        bloc.add(EditGame(updatedGame));
      },
      expect: () => [
        GameError(),
      ],
    );
  });

  group('DeleteGame', () {
    final String gameId = '1';
    final List<Game> games = [
      Game(id: '2', name: 'Game 2', image: 'image2.png'),
    ];

    blocTest<GameBloc, GameState>(
      'emits [GameLoadSuccess] when deleteGame succeeds',
      build: () {
        when(mockGameRepository.deleteGame(gameId)).thenAnswer((_) async {
          print('Mock: deleteGame() called');
        });
        when(mockGameRepository.fetchGames()).thenAnswer((_) async {
          print('Mock: fetchGames() called');
          return games;
        });
        return gameBloc;
      },
      act: (bloc) {
        print('Act: DeleteGame event added');
        bloc.add(DeleteGame(gameId));
      },
      expect: () => [
        GameLoadSuccess(games),
      ],
    );

    blocTest<GameBloc, GameState>(
      'emits [GameError] when deleteGame fails',
      build: () {
        when(mockGameRepository.deleteGame(gameId))
            .thenThrow(Exception('Error deleting game'));
        return gameBloc;
      },
      act: (bloc) {
        print('Act: DeleteGame event added');
        bloc.add(DeleteGame(gameId));
      },
      expect: () => [
        GameError(),
      ],
    );
  });
}
