import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/application/auth/auth_bloc.dart';
import 'package:frontend/infrastructure/auth/auth_repository.dart';
import 'package:frontend/infrastructure/auth/auth_service.dart';
import 'package:frontend/application/game/game_bloc.dart';
import 'package:frontend/infrastructure/game/game_repository.dart';
import 'package:frontend/infrastructure/game/game_service.dart';
import 'package:frontend/presentation/screens/about.dart';
import 'package:frontend/presentation/screens/game_add.dart';
import 'package:frontend/presentation/screens/game_detail.dart';
import 'package:frontend/presentation/screens/login.dart';
import 'package:frontend/presentation/screens/home.dart';
import 'package:frontend/presentation/screens/register.dart';
import 'package:frontend/presentation/screens/admin_page.dart';
import 'package:frontend/presentation/screens/review.dart';
import 'package:frontend/presentation/screens/review_edit.dart';
import 'package:frontend/presentation/screens/search.dart';
import 'package:frontend/presentation/screens/users.dart';
import 'package:frontend/presentation/screens/onboarding_screen.dart';
import 'package:frontend/presentation/screens/rating_page.dart';
import 'package:frontend/application/review/review_bloc.dart';
import 'package:frontend/infrastructure/review/review_repository.dart';
import 'package:frontend/infrastructure/review/review_service.dart';
import 'package:frontend/application/user/users_bloc.dart';
import 'package:frontend/infrastructure/user/users_repository.dart';
import 'package:frontend/infrastructure/user/users_service.dart';
import 'package:go_router/go_router.dart';

import '../screens/profile.dart';

class BetApp extends StatelessWidget {
  const BetApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize the GameRepository
    final gameService = GameService();
    final gameRepository = GameRepository(gameService);

    // Initialize UserRepository
    final userService = UsersService();
    final userRepository = UsersRepository(userService: userService);

    // Initialize AuthRepository
    final authService = AuthService();
    final authRepository = AuthRepository(authService: authService);

    // Initialize the ReviewRepository
    final reviewService = ReviewService();
    final reviewRepository = ReviewRepository(reviewService);

    final router = GoRouter(
      initialLocation: '/onboarding',
      routes: [
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => OnboardingScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegistrationPage(),
        ),
        GoRoute(
          path: '/review',
          builder: (context, state) {
            final Map<String, dynamic> args =
                state.extra as Map<String, dynamic>;
            final String gameId = args['gameId'];

            return ReviewPage(gameId: gameId);
          },
        ),
        GoRoute(
          path: '/admin',
          builder: (context, state) => const AdminPage(),
        ),
        GoRoute(
          path: '/add_game',
          builder: (context, state) => const AddGameForm(buttonName: "Add"),
        ),
        GoRoute(
          path: '/about',
          builder: (context, state) => AboutPage(),
        ),
        GoRoute(
          path: '/users',
          builder: (context, state) => const UsersPage(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/search',
          builder: (context, state) => const SearchPage(),
        ),
        GoRoute(
          path: '/review-edit',
          builder: (context, state) => ReviewEdit(),
        ),
        GoRoute(
          path: '/review-page',
          builder: (context, state) {
            final Map<String, dynamic> args =
                state.extra as Map<String, dynamic>;
            final String gameId = args['gameId'];

            return RatingForm(gameId: gameId);
          },
        ),
        GoRoute(
          path: '/game-detail',
          builder: (context, state) {
            final Map<String, dynamic> args =
                state.extra as Map<String, dynamic>;
            final game = args['game'];

            return GameDetailPage(game: game);
          },
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GameBloc(gameRepository),
        ),
        BlocProvider(
          create: (context) => UsersBloc(userRepository),
        ),
        BlocProvider(
          create: (context) => AuthBloc(authRepository: authRepository),
        ),
        BlocProvider(
          create: (context) => ReviewBloc(reviewRepository),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'BetEbet',
        routerConfig: router,
        theme: ThemeData.dark(),
      ),
    );
  }
}

void main() {
  runApp(const BetApp());
}
