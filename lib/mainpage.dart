import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:movietime/model/navbar.dart';
import 'package:movietime/model/sharedpref.dart';
import 'package:movietime/widgets/api_key.dart';

import 'package:movietime/widgets/colrow.dart';
import 'package:movietime/widgets/topMovies.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/colordata.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>(); //for scaffold drawer bar

  static String url = 'https://api.themoviedb.org/3/';
  //final String image_url = 'https://image.tmdb.org/t/p/original';

  var resTrendingMovies,
      trendingMovies,
      resPopularMovies,
      popularMovies,
      resinCinema,
      cinemaMovie,
      resUpcomming,
      upcommingMovies,
      newsReq;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    resTrendingMovies =
        await http.get(url + 'trending/movie/day?api_key=' + key);
    trendingMovies = jsonDecode(resTrendingMovies.body)["results"];

    resPopularMovies = await http
        .get(url + 'movie/popular?api_key=' + key + '&language=en-US&page=1');
    popularMovies = jsonDecode(resPopularMovies.body)["results"];

    resinCinema = await http.get(url +
        'movie/now_playing?api_key=' +
        key +
        '&language=en-US&page=1&region=us');
    cinemaMovie = jsonDecode(resinCinema.body)["results"];

    resUpcomming = await http
        .get(url + 'movie/upcoming?api_key=' + key + '&language=en-US&page=1');
    upcommingMovies = jsonDecode(resUpcomming.body)["results"];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavBar(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.menu,
              size: 28.0,
            ),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            }),
        title: Text('movietime',
            style: GoogleFonts.fredokaOne(
              color: Color(0xfffb5558),
              fontWeight: FontWeight.w500,
              fontSize: 28.0,
            )),
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                size: 28.0,
              ),
              onPressed: () {
                showSearch(context: context, delegate: SearchData());
              }),
          IconButton(
              icon: Icon(Icons.person, size: 28.0),
              onPressed: () {
                print("Profile");
              }),
        ],
      ),
      body: SingleChildScrollView(
          child: resTrendingMovies == null ||
                  resPopularMovies == null ||
                  resinCinema == null ||
                  resUpcomming == null
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    SizedBox(height: 10.0),
                    TopMix(
                        movieList: trendingMovies), //Top Movie & series Section
                    SizedBox(height: 25.0),
                    Category(
                      title: "MOST POPULAR MOVIES",
                      popularMovies: popularMovies,
                      width: 180.0,
                      height: 250.0,
                      home: true,
                    ),
                    SizedBox(height: 20.0),
                    Category(
                      title: "NOW PLAYING",
                      popularMovies: cinemaMovie,
                      width: 280,
                      height: 240,
                      home: true,
                    ),
                    Category(
                      title: "COMING SOON",
                      popularMovies: upcommingMovies,
                      width: 150,
                      height: 200,
                      home: true,
                    ),
                  ],
                )),
    );
  }
}

class SearchData extends SearchDelegate<String> {
  List<String> movieHistory = [
    "Avengers End Game",
    "X-men Days of Future Past",
  ];
  SharedFiles obj;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () => {close(context, null)});
  }

  @override
  Widget buildResults(BuildContext context) {
    SharedFiles().start();
    if (query != '') {
      movieHistory.insert(0, query);
      SharedFiles().setMovies(movieHistory);
    }

    return Text('No Data');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (SharedFiles().checkMovie()) movieHistory = SharedFiles().getMovies();
    return ListView.builder(
      itemCount: movieHistory.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          key: Key(movieHistory.length.toString()),
          leading: Icon(Icons.history),
          title: Text('${movieHistory[index]}',
              style: TextStyle(
                color: textColor,
                fontSize: 20.0,
              )),
          trailing: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                movieHistory.removeAt(index);
                SharedFiles().setMovies(movieHistory);
              }),
        );
      },
    );
  }
}
