import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2),
              BlendMode.dstATop,
            ),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                'assets/RussianRoulette.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              OnboardingPage1(),
              OnboardingPage2(),
            ],
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: IconButton(
              icon: Icon(
                Icons.arrow_forward_sharp,
                color: _currentPage == 1
                    ? Colors.grey
                    : const Color.fromARGB(255, 18, 94, 217),
              ),
              onPressed: () {
                if (_currentPage == 1) {
                  context.go('/login');
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ),
          Positioned(
            bottom: 20.0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  2,
                  (index) => Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index
                          ? Colors.grey.shade400
                          : Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/game9.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logo.jpg",
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome to BetEbet',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Embark on a Thrilling Betting Adventure with BetEbet. Explore a world of sports betting, casino games, and more at your fingertips.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 211, 47, 47),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.home_filled,
                size: 50,
              ),
              SizedBox(height: 30),
              Text(
                'Discover the Thrill of Betting with BetEbet',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'BetEbet offers a seamless and engaging platform to indulge in your passion for betting and experience the excitement of wagering like never before.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
