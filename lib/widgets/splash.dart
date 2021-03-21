import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movietime/firebase/authentication.dart';
import 'package:movietime/mainpage.dart';
import 'package:movietime/widgets/login_signup/loginpage.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  final Color backgroundColor = Colors.white;
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 2;

  // @override
  // void initState() {
  //   super.initState();
  //   //_loadScreen();
  // }

  // _loadScreen() async {
  //   var _duration = Duration(seconds: splashDelay);
  //   return Timer(_duration, navigationPage());
  // }

  void navigationPage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationServices object =
        Provider.of<AuthenticationServices>(context);

    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text('movietime',
                  style: GoogleFonts.fredokaOne(
                    color: Color(0xfffb5558),
                    fontWeight: FontWeight.w500,
                    fontSize: MediaQuery.of(context).size.width * 0.13,
                  )),
            ),
            StreamBuilder<User>(
                stream: object.authStateChange,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (!snapshot.hasData) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        var duration = Duration(seconds: 1);
                        Timer(duration, navigationPage);
                      });
                    } else {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => MainPage()));
                      });
                    }
                  }
                  return CircularProgressIndicator();
                })
          ],
        ),
      ),
    );
  }
}
