import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:movietime/model/navbar.dart';

import 'package:movietime/widgets/colrow.dart';
import 'package:movietime/widgets/topMovies.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>(); //for scaffold drawer bar
  final String key = '';
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
                print("Search");
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
                    ),
                    SizedBox(height: 20.0),
                    Category(
                      title: "NOW PLAYING",
                      popularMovies: cinemaMovie,
                      width: 280,
                      height: 240,
                    ),
                    Category(
                      title: "COMING SOON",
                      popularMovies: upcommingMovies,
                      width: 150,
                      height: 200,
                    ),
                  ],
                )),
    );
  }
}
