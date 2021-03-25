import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movietime/firebase/authentication.dart';
import 'package:movietime/widgets/login_signup/loginpage.dart';
import 'package:movietime/widgets/misc/profile.dart';
import 'package:movietime/widgets/misc/setting.dart';
import 'package:provider/provider.dart';

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
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => Profile()));
          },
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.cog),
          title: Text('Settings'),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => Settings()));
          },
        ),
        ListTile(
          leading: Icon(
            Icons.logout,
            color: Colors.redAccent[100],
          ),
          title: Text('Logout'),
          onTap: () {
            context
                .read<AuthenticationServices>()
                .signOut()
                .whenComplete(() => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => LoginPage()),
                    ));
          },
        )
      ]),
    );
  }
}
