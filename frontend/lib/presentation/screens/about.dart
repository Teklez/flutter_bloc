import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 211, 47, 47),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              context.pop();
            },
          )),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              Center(
                child: Text(
                  'Welcome to BetEbet',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: Text(
                  'Explore an exhilarating world of online gambling where luck and skill intertwine, offering endless opportunities to win big.',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: Text(
                  'It aint gambling if you always win!',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Icon(Icons.person),
                        SizedBox(height: 8.0),
                        Text('Total Users'),
                        Text('500+'),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.emoji_events),
                        SizedBox(height: 8.0),
                        Text('Total Winners'),
                        Text('368'),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.casino),
                        SizedBox(height: 8.0),
                        Text('Total Bets'),
                        Text('19999'),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.attach_money),
                        SizedBox(height: 8.0),
                        Text('Total Deposit'),
                        Text('500000+'),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 200.0,
                color: const Color.fromARGB(181, 224, 224, 224),
                child: Image.asset(
                  'assets/game11.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10.0),
                    Center(
                      child: Text(
                        'BetEbet is an online gambling website that offers a wide range of casino games and sports betting options. With a user-friendly interface and a focus on responsible gambling, BetEbet provides a secure and enjoyable experience. Their dedicated customer support team is available 24/7 to assist users. BetEbet aims to delive entertainment, excitement, and the opportunity to win big for gambling enthusiasts.',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Center(
                      child: Text(
                        'This online platform offers casino games, sports betting, and customer support, all designed for a secure and entertaining gambling experience.',
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.black,
                  ),
                  child: Text(
                    'Wanna Bet',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                //edit the color

                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'What games do we have?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Column(
                      children: [
                        Text(
                          "Dice:  Rolling the dice, chance takes hold as possibilities unfold.",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Blackjack: The game of strategy and chance, where the goal is to reach twenty-one",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Roulette:  A dangerous game of chance, where life hangs on the spin of a deadly chamber.",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Slots: The thrilling game of spinning reels, where luck and anticipation collide for a chance at winning big",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Craps:  The exhilarating dice game where the roll of the dice can determine your fate at the table.",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Pocker: The captivating game of skill and strategy, where players bluff, bet, and compete for the ultimate hand",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'What do we provide?',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Center(
                      child: Text(
                        'An easy and simple system you can bet on!',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('Secure'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('Fast'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('Esy to use'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text('24/7 support'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
