import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/presentation/widgets/dialogues.dart';
import 'package:frontend/presentation/widgets/drawer.dart';
import 'package:frontend/application/user/users_bloc.dart';
import 'package:frontend/presentation/events/users_event.dart';
import 'package:frontend/presentation/states/users_state.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final UsersBloc userBloc = BlocProvider.of<UsersBloc>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userBloc.add(const FetchUsers());
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 211, 47, 47),
        title: const Text("BetEbet"),
      ),
      drawer: const MenuDrawer(menuItems: [
        ["Home", '/admin'],
        ["Users", '/users'],
        ["Profile", '/profile'],
        ["Add Game", '/add_game'],
        ["Logout", '/login']
      ]),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is UsersEmpty) {
            return const Center(child: Text("No users found"));
          } else if (state is UsersLoadSuccess) {
            return ListView(
              children: _buildUserCard(state.users),
            );
          } else if (state is UsersError) {
            return Center(child: Text("Error loading users"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  List<Card> _buildUserCard(users) {
    List<Card> cards = [];
    for (var i = 0; i < users.length; i++) {
      var card = Card(
        child: ListTile(
          leading: Icon(Icons.person, color: Color.fromARGB(255, 211, 47, 47)),
          title: Text(users[i].username),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Role: ${users[i].roles}"),
              Text("Status: ${users[i].status}"),
            ],
          ),
          trailing: BlockRole(user: users[i]),
        ),
      );
      cards.add(card);
    }
    return cards;
  }
}
