import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'mainpage.dart';
import 'widgets/misc/sharedpref.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedFiles().start();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movietime',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
      ),
      home: MainPage(),
    );
  }
}
