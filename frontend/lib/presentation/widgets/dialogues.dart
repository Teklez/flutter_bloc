import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/game/game_bloc.dart';
import 'package:frontend/game/game_events.dart';
import 'package:frontend/presentation/screens/game_add.dart';
import 'package:frontend/users/users_bloc.dart';
import 'package:frontend/users/users_event.dart';

// EDIT DELETE DIALOGUE
// This dialogue is used to edit or delete a game. It is used in the AdminGameCard widget.

class EditDeleteDialogue extends StatelessWidget {
  final route;
  final data;
  final feature;
  const EditDeleteDialogue(
      {super.key,
      required this.route,
      required this.data,
      required this.feature});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: const Icon(Icons.more_vert),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.edit),
              Text("EDIT"),
            ],
          ),
          onTap: () {
            print("pushd to the page");

            if (feature == 'game') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AddGameForm(buttonName: 'Edit', initialGame: data),
                ),
              );
            }

            // the same for review feature
          }, // menu setting
        ),
        PopupMenuItem(
          value: 2,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.delete, color: Colors.redAccent),
              Text("DELETE"),
            ],
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AreYouSureDialogue(
                data: data,
                feature: 'game',
              ),
            );
          }, // menu setting
        ),
      ],
    );
  }
}

// BLOCK ROLE
// This widget is used to block a user or change their role. It is used in the UsersPage widget.

class BlockRole extends StatelessWidget {
  final user;
  const BlockRole({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: const Icon(Icons.more_vert),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(Icons.block),
              Text(user.status == 'unblocked'
                  ? "BLOCK           "
                  : "UNBLOCK    "),
            ],
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AreYouSureDialogue(data: user, feature: 'userstatus');
              },
            );
          },
        ),
        PopupMenuItem(
          value: 2,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.change_circle),
              Text("CHANGE ROLE"),
            ],
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) =>
                  AreYouSureDialogue(data: user, feature: 'userrole'),
            );
          },
        ),
      ],
    );
  }
}

// ARE YOU SURE DIALOGUE
// This dialogue is used to confirm if the user is sure of the action they are about to take.

class AreYouSureDialogue extends StatelessWidget {
  final data;
  final feature;
  const AreYouSureDialogue(
      {super.key, required this.data, required this.feature});

  @override
  Widget build(BuildContext context) {
    GameBloc gameBloc = BlocProvider.of<GameBloc>(context);
    UsersBloc usersBloc = BlocProvider.of<UsersBloc>(context);
    return AlertDialog(
      title: const Text("Are you sure?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            if (feature == 'game') {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                gameBloc.add(DeleteGame(data.id));
              });
            } else if (feature == 'userstatus') {
              if (data.status == 'unblocked') {
                data.status = 'blocked';
              } else {
                data.status = 'unblocked';
              }
              WidgetsBinding.instance.addPostFrameCallback((_) {
                usersBloc.add(ChangeStatus(data));
              });

              // add the logic to block user
            } else if (feature == 'userrole') {
              if (data.roles == 'user') {
                data.roles = 'admin';
              } else {
                data.roles = 'user';
              }
              WidgetsBinding.instance.addPostFrameCallback((_) {
                usersBloc.add(ChangeStatus(data));
              });
              // add the logic to change user role
            }

            // the same for review feature

            Navigator.pop(context);
          },
          child: const Text("Yes"),
        ),
      ],
    );
  }
}

// FILTER DIALOGUE
class Filter extends StatelessWidget {
  const Filter({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      child: Icon(Icons.tune),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: "All",
          child: Text("All"),
        ),
        const PopupMenuItem(
          child: Text("4.5"),
        ),
        const PopupMenuItem(
          child: Text("4.8"),
        ),
      ],
    );
  }
}
