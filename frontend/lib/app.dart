import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/auth/auth_bloc.dart';
import 'package:frontend/auth/auth_repository.dart';
import 'package:frontend/auth/auth_service.dart';
import 'package:frontend/game/game_bloc.dart';
import 'package:frontend/game/game_model.dart';
import 'package:frontend/game/game_repository.dart';
import 'package:frontend/game/game_service.dart';
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
import 'package:frontend/presentation/widgets/rating_page.dart';
import 'package:frontend/review/review_bloc.dart';
import 'package:frontend/review/review_repository.dart';
import 'package:frontend/review/review_service.dart';
import 'package:frontend/users/users_bloc.dart';
import 'package:frontend/users/users_repository.dart';
import 'package:frontend/users/users_service.dart';

import 'presentation/screens/profile.dart';

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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BetEbet',
        initialRoute: '/onboarding',
        routes: {
          '/onboarding': (BuildContext context) => OnboardingScreen(),
          '/login': (BuildContext context) => const LoginPage(),
          '/': (BuildContext context) => const HomePage(),
          '/register': (BuildContext context) => const RegistrationPage(),
          '/review': (BuildContext context) => const ReviewPage(),
          '/admin': (BuildContext context) => const AdminPage(),
          '/add_game': (BuildContext context) =>
              const AddGameForm(buttonName: "Add"),
          '/about': (BuildContext context) => AboutPage(),
          '/users': (BuildContext context) => const UsersPage(),
          '/home': (BuildContext context) => const HomePage(),
          '/search': (BuildContext context) => const SearchPage(),
          '/review-edit': (BuildContext context) => ReviewEdit(),
          '/review-page': (BuildContext context) => RatingForm(),
          '/game_details': (BuildContext context) => GameDetailPage(
              game: Game(image: "assets/game1.jpg", name: "Game 1")),
          '/profile': (BuildContext context) => const ProfilePage(),
        },
        theme: ThemeData.dark(),
      ),
    );
  }
}
