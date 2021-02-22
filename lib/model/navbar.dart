import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        DrawerHeader(
          child: Text(
            'Hi, Jatin Mohan',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 25.0,
            ),
          ),
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.home),
          title: Text('Home'),
          onTap: () => print("HOME"),
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.userAlt),
          title: Text('Profile'),
          onTap: () => print("HOME"),
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.users),
          title: Text('Celebrities'),
          onTap: () => print("HOME"),
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.cog),
          title: Text('Settings'),
          onTap: () => print("HOME"),
        ),
        //SizedBox(height: MediaQuery.of(context).size.height * 0.25),
        ListTile(
          leading: Icon(
            Icons.logout,
            color: Colors.redAccent[100],
          ),
          title: Text('Logout'),
          onTap: () => print("HOME"),
        )
      ]),
    );
  }
}
