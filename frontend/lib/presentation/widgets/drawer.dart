import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  final List<List<String>> menuItems;
  const MenuDrawer({super.key, required this.menuItems});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Center(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/logo.jpg'),
                  fit: BoxFit.cover,
                  opacity: 0.3,
                  colorFilter: ColorFilter.mode(
                      Color.fromARGB(255, 18, 18, 18).withOpacity(0.5),
                      BlendMode.dstATop),
                ),
              ),
              child: const Text('BetEbet'),
            ),
            ..._buildTile(menuItems, context)
          ],
        ),
      ),
    );
  }

  List<ListTile> _buildTile(menuItems, context) {
    List<ListTile> tiles = [];
    for (var item in menuItems) {
      var icon;
      switch (item[0]) {
        case "Home":
          icon = Icons.home;
          break;
        case "Profile":
          icon = Icons.person;
          break;
        case "About":
          icon = Icons.info;
          break;
        case "Logout":
          icon = Icons.logout;
          break;
        case "Users":
          icon = Icons.people;
          break;
        case "Add Game":
          icon = Icons.add;
          break;
        default:
          Icons.home;
      }
      tiles.add(
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(icon),
              const SizedBox(
                width: 40,
              ),
              Text(item[0]),
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, "${item[1]}");
          },
        ),
      );
    }
    return tiles;
  }
}
