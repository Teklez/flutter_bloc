import 'package:flutter/material.dart';
import 'package:frontend/model/user.dart';
import 'package:frontend/presentation/widgets/dialogues.dart';
import 'package:frontend/presentation/widgets/drawer.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    List users = [
      User(name: "User 1", role: "Admin"),
      User(name: "User 2", role: "User"),
      User(name: "User 3", role: "User"),
      User(name: "User 4", role: "User"),
      User(name: "User 5", role: "User"),
      User(name: "User 6", role: "User"),
      User(name: "User 7", role: "User"),
      User(name: "User 8", role: "User"),
      User(name: "User 9", role: "User"),
      User(name: "User 10", role: "User"),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 211, 47, 47),
        title: const Text("BetEbet"),
      ),
      drawer: const MenuDrawer(menuItems: [
        ["Home", '/admin'],
        ["Users", '/users'],
        ["Add Game", '/add_game'],
        ["Logout", '/login']
      ]),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: _buildUserCard(users),
      ),
    );
  }

  List<Card> _buildUserCard(users) {
    List<Card> cards = [];
    for (var i = 0; i < users.length; i++) {
      var card = Card(
        child: ListTile(
          leading: Icon(Icons.person, color: Color.fromARGB(255, 211, 47, 47)),
          title: Text(users[i].name),
          subtitle: Text(users[i].role),
          trailing: const BlockRole(),
        ),
      );
      cards.add(card);
    }
    return cards;
  }
}
