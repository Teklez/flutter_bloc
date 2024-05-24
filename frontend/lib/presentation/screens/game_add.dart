import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddGameForm extends StatelessWidget {
  final String buttonName;
  const AddGameForm({Key? key, required this.buttonName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Material(
        child: Container(
            margin: const EdgeInsets.only(top: 50.0), // Add margin
            padding: const EdgeInsets.all(18.0),
            child: Center(
              child: _addGameForm(context, buttonName),
            )),
      ),
    );
  }

  _addGameForm(context, buttonName) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Image URL",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10.0),
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Name",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10.0),
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Description",
            border: OutlineInputBorder(),
          ),
          maxLines: 5,
        ),
        const SizedBox(height: 10.0),
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Publisher",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/admin', (route) => false);
                // Cancel action
                print('Cancel');
              },
              child: Text('Cancel',
                  style: TextStyle(color: Color.fromARGB(255, 211, 63, 63))),
            ),
            const SizedBox(width: 10.0), // Add spacing between buttons
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/admin', (route) => false);
                // Add action
                print('Add');
              },
              child: Text(buttonName,
                  style: TextStyle(color: Color.fromARGB(255, 47, 211, 151))),
            ),
          ],
        ),
      ],
    );
  }
}
