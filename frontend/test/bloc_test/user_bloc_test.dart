import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/application/user/users_bloc.dart';
import 'package:frontend/presentation/events/users_event.dart';
import 'package:frontend/presentation/states/users_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:frontend/infrastructure/user/users_repository.dart';
import 'package:frontend/domain/users_model.dart';
import 'user_bloc_test.mocks.dart';

@GenerateMocks([UsersRepository])
void main() {
  group('UsersBloc', () {
    late MockUsersRepository mockUsersRepository;
    late UsersBloc usersBloc;

    setUp(() {
      mockUsersRepository = MockUsersRepository();
      usersBloc = UsersBloc(mockUsersRepository);
    });

    tearDown(() {
      usersBloc.close();
    });

    test('initial state is UsersInitial', () {
      expect(usersBloc.state, UsersInitial());
      print('Initial state is UsersInitial');
    });

    blocTest<UsersBloc, UsersState>(
      'emits [UsersEmpty] when fetchUsers succeeds and users are empty',
      build: () {
        when(mockUsersRepository.fetchUsers()).thenAnswer((_) async => []);
        return usersBloc;
      },
      act: (bloc) => bloc.add(const FetchUsers()),
      expect: () => [UsersEmpty()],
      verify: (_) {
        print('FetchUsers event added, expecting UsersEmpty');
        verify(mockUsersRepository.fetchUsers()).called(1);
      },
    );

    blocTest<UsersBloc, UsersState>(
      'emits [UsersError] when fetchUsers fails',
      build: () {
        when(mockUsersRepository.fetchUsers())
            .thenThrow(Exception('Failed to fetch users'));
        return usersBloc;
      },
      act: (bloc) => bloc.add(const FetchUsers()),
      expect: () => [UsersError()],
      verify: (_) {
        print('FetchUsers event added, expecting UsersError');
        verify(mockUsersRepository.fetchUsers()).called(1);
      },
    );

    blocTest<UsersBloc, UsersState>(
      'emits [UsersError] when changeStatus fails',
      build: () {
        when(mockUsersRepository.changeStatus(any))
            .thenThrow(Exception('Failed to change status'));
        return usersBloc;
      },
      act: (bloc) => bloc.add(ChangeStatus(
          User(id: '1', username: 'user1', password: 'password1'))),
      expect: () => [UsersError()],
      verify: (_) {
        print('ChangeStatus event added, expecting UsersError');
        verify(mockUsersRepository.changeStatus(any)).called(1);
      },
    );
  });
}
