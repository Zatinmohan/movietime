import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movietime/widgets/misc/navbar.dart';
import 'package:movietime/widgets/misc/appbar.dart';
import 'package:movietime/widgets/categories/colrow.dart';
import 'package:movietime/widgets/categories/topMovies.dart';

import 'api/api.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>(); //for scaffold drawer bar

  List<dynamic> valueList = new List();

  DateTime currentBackPressTime;

  @override
  void initState() {
    super.initState();
    valueList.add(APIManager().getTrendingMovies());
    valueList.add(APIManager().getPopularMovies());
    valueList.add(APIManager().getNowPlaying());
    valueList.add(APIManager().getupComing());
  }

  Future<bool> backTwiceToExit() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Press Again to Exit");
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavBar(),
      appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
      body: WillPopScope(
        onWillPop: backTwiceToExit,
        child: SingleChildScrollView(
            child: Column(
          children: [
            //SizedBox(height: 10.0),
            TopMix(movieBuilder: valueList[0]), //Top Movie & series Section

            SizedBox(height: 25.0),

            Category(
              title: "MOST POPULAR MOVIES",
              movieBuilder: valueList[1],
              width: 180.0,
              height: 250.0,
              home: true,
            ),
            SizedBox(height: 20.0),
            Category(
              title: "NOW PLAYING",
              movieBuilder: valueList[2],
              width: 280,
              height: 240,
              home: true,
            ),
            Category(
              title: "COMING SOON",
              movieBuilder: valueList[3],
              width: 150,
              height: 200,
              home: true,
            ),
          ],
        )),
      ),
    );
  }
}
