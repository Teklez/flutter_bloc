import 'package:flutter/material.dart';

// EDIT DELETE DIALOGUE
// This dialogue is used to edit or delete a game. It is used in the AdminGameCard widget.

class EditDeleteDialogue extends StatelessWidget {
  final route;
  const EditDeleteDialogue({super.key, required this.route});

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
            Navigator.pushNamed(context, route);
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
              builder: (context) => const AreYouSureDialogue(),
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
  const BlockRole({super.key});

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
              Icon(Icons.block),
              Text("BLOCK           "),
            ],
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => const AreYouSureDialogue(),
            );
          },
        ),
        const PopupMenuItem(
          value: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.change_circle),
              Text("CHANGE ROLE"),
            ],
          ),
        ),
      ],
    );
  }
}

// ARE YOU SURE DIALOGUE
// This dialogue is used to confirm if the user is sure of the action they are about to take.

class AreYouSureDialogue extends StatelessWidget {
  const AreYouSureDialogue({super.key});

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
