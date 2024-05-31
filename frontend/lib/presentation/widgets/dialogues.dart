import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/application/auth/auth_bloc.dart';
import 'package:frontend/application/game/game_bloc.dart';
import 'package:frontend/application/review/review_bloc.dart';
import 'package:frontend/application/user/users_bloc.dart';
import 'package:frontend/presentation/events/auth_event.dart';
import 'package:frontend/presentation/events/game_events.dart';
import 'package:frontend/presentation/events/review_event.dart';
import 'package:frontend/presentation/events/users_event.dart';
import 'package:frontend/presentation/screens/game_add.dart';
import 'package:frontend/presentation/screens/review_edit.dart';

import 'package:go_router/go_router.dart';

// EDIT DELETE DIALOGUE
// This dialogue is used to edit or delete a game. It is used in the AdminGameCard widget.

class EditDeleteDialogue extends StatelessWidget {
  final String route;
  final data;
  final String feature;
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
            print("pushed to the page");

            if (feature == 'game') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AddGameForm(buttonName: 'Edit', initialGame: data),
                ),
              );
            } else if (feature == 'review') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReviewEdit(review: data),
                ),
              );
            }
          },
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
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (feature == "game") {
                showDialog(
                  context: context,
                  builder: (context) => AreYouSureDialogue(
                    data: data,
                    feature: 'game',
                  ),
                );
              } else if (feature == "review") {
                showDialog(
                  context: context,
                  builder: (context) => AreYouSureDialogue(
                    data: data,
                    feature: 'review',
                  ),
                );
              }
            });
          },
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
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                builder: (context) {
                  return AreYouSureDialogue(data: user, feature: 'userstatus');
                },
              );
            });
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
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                builder: (context) =>
                    AreYouSureDialogue(data: user, feature: 'userrole'),
              );
            });
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
              BlocProvider.of<GameBloc>(context).add(DeleteGame(data.id));
            } else if (feature == 'userstatus') {
              if (data.status == 'unblocked') {
                data.status = 'blocked';
              } else {
                data.status = 'unblocked';
              }
              BlocProvider.of<UsersBloc>(context).add(ChangeStatus(data));
            } else if (feature == 'userrole') {
              if (data.roles == 'user') {
                data.roles = 'admin';
              } else {
                data.roles = 'user';
              }
              BlocProvider.of<UsersBloc>(context).add(ChangeStatus(data));
            } else if (feature == 'logout') {
              BlocProvider.of<AuthBloc>(context)
                  .add(UserLoggedOut(message: data));
            } else if (feature == 'review') {
              BlocProvider.of<ReviewBloc>(context)
                  .add(DeleteReview(data['data'].id, data['gameId']));
              // context.pushReplacement('/review',
              //     extra: {'gameId': data['gameId']});
            } else if (feature == 'profile') {
              BlocProvider.of<AuthBloc>(context).add(UserDeleted(id: data));
            }
            context.pop();

            if (feature == 'profile') {
              context.go('/register');
            }
            if (feature == 'logout') {
              context.go('/login');
            }
          },
          child: const Text("Yes"),
        ),
      ],
    );
  }
}
