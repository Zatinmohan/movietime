import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movietime/firebase/authentication.dart';
import 'package:movietime/mainpage.dart';
import 'package:movietime/widgets/login_signup/loginpage.dart';
import 'package:movietime/widgets/profile/profile.dart';
import 'package:movietime/widgets/misc/settings.dart';
import 'package:movietime/widgets/movie%20details/savedMovies.dart';
import 'package:provider/provider.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Center(
        child: Column(children: [
          DrawerHeader(
            child: Center(
              child: StreamBuilder<DocumentSnapshot>(
                stream: context.read<AuthenticationServices>().getDataBase(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    String name = snapshot.data.get('name').toString();
                    if (snapshot.hasData) {
                      return Text(
                        name != null ? 'Hey, $name' : 'Hi Unknown',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 25.0,
                        ),
                      );
                    } else {
                      return Text(
                        'Hi, Unknown',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 25.0,
                        ),
                      );
                    }
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: Icon(FontAwesomeIcons.home),
                title: Text('Home'),
                onTap: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => MainPage())),
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
                leading: Icon(FontAwesomeIcons.solidHeart),
                title: Text('Liked Movies'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => SavedMovies()));
                },
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.cog),
                title: Text('Settings'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => UserPreference()));
                },
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  size: 25.0,
                  color: Colors.redAccent[100],
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17.0,
                  ),
                ),
                onTap: () {
                  context.read<AuthenticationServices>().signOut().whenComplete(
                      () => Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => LoginPage()),
                          (route) => false)
                      //Navigator.pushAndRemoveUntil(
                      //     context,
                      //     MaterialPageRoute(builder: (_) => LoginPage()),
                      //     (Route<dynamic> route) => false)
                      );
                },
              ),
            ),
          )
        ]),
      ),
    );
  }
}
