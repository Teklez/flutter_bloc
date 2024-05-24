import 'package:flutter/material.dart';
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

class BetApp extends StatelessWidget {
  const BetApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BetEbet',
      initialRoute: '/onboarding',
      routes: {
        '/onboarding': (BuildContext contex) => OnboardingScreen(),
        '/login': (BuildContext context) => const LoginPage(),
        '/': (BuildContext context) => const HomePage(),
        '/register': (BuildContext context) => const RegistrationPage(),
        '/review': (BuildContext context) => const ReviewPage(),
        '/admin': (BuildContext context) => const AdminPage(),
        '/add_game': (BuildContext context) => const AddGameForm(
              buttonName: "Add",
            ),
        '/about': (BuildContext context) => AboutPage(),
        '/users': (BuildContext context) => const UsersPage(),
        '/home': (BuildContext context) => const HomePage(),
        '/search': (BuildContext context) => const SearchPage(),
        '/review-edit': (BuildContext context) => ReviewEdit(),
        '/review-page': (BuildContext context) => RatingForm(),
        '/game_details': (BuildContext context) => GameDetailPage(),
      },
      theme: ThemeData.dark(),
    );
  }
}
