import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:movietime/model/colordata.dart';
import 'package:movietime/widgets/movie%20details/RowButtons.dart';
import 'package:movietime/model/api_key.dart';
import 'package:movietime/widgets/movie%20details/cast.dart';
import 'package:movietime/widgets/categories/colrow.dart';
import 'package:movietime/widgets/movie%20details/detailLayout.dart';
import 'package:movietime/widgets/movie%20details/movieInfo.dart';
import 'package:movietime/widgets/movie%20details/photos.dart';

import 'package:movietime/widgets/movie%20details/storyline.dart';

class MovieDetail extends StatefulWidget {
  final int id;

  const MovieDetail({Key key, this.id}) : super(key: key);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  var res, movie, recom;
  var providers;
  String image_url = 'https://image.tmdb.org/t/p/original';
  double rating;
  List<String> genreList = new List();
  int runtime;
  String p, b;
  Map<dynamic, dynamic> watch;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    print(widget.id);
    res = await https.get('https://api.themoviedb.org/3/movie/' +
        widget.id.toString() +
        '?api_key=' +
        key +
        '&append_to_response=credits,watch/providers,images');

    var rec = await https.get('https://api.themoviedb.org/3/movie/' +
        widget.id.toString() +
        '/recommendations?api_key=' +
        key +
        '&language=en-US&page=1');

    recom = jsonDecode(rec.body)['results'];

    movie = jsonDecode(res.body);

    String poster = movie['poster_path'];
    String backdrop = movie['backdrop_path'];

    if (poster != null || poster.length != 0)
      p = image_url + poster;
    else
      p = null;

    if (backdrop != null || backdrop.length != 0)
      b = image_url + backdrop;
    else
      b = null;

    rating = movie['vote_average'];
    runtime = movie['runtime'];

    var genre = movie['genres'];
    for (int i = 0; i < genre.length; i++) {
      genreList.add(genre[i]['name'].toString());
    }

    providers = movie["watch/providers"]["results"];
    if (providers["US"] == null)
      providers = null;
    else {
      providers = providers["US"];
      if (providers['flatrate'] == null)
        providers = providers['rent'];
      else if (providers['rent'] == null)
        providers = providers['flatrate'];
      else
        providers = null;
    }

    setState(() {});
  }

  String moneyCalculator(int budget) {
    if (budget > 999 && budget < 99999) {
      return "${(budget / 1000).toStringAsFixed(1)} K";
    } else if (budget > 99999 && budget < 999999) {
      return "${(budget / 1000).toStringAsFixed(0)} K";
    } else if (budget > 999999 && budget < 999999999) {
      return "${(budget / 1000000).toStringAsFixed(1)} M";
    } else if (budget > 999999999) {
      return "${(budget / 1000000000).toStringAsFixed(1)} B";
    }
    return "N/A";
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: movie == null
          ? CircularProgressIndicator()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height * 0.65,
                    //color: Colors.blue,
                    child: Stack(
                      children: [
                        ClipPath(
                          clipper: SemiCircle(),
                          child: Container(
                            height: height * 0.45,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0.0, 3.0),
                                    blurRadius: 6.0,
                                    color: Colors.black26,
                                  )
                                ],
                                image: DecorationImage(
                                  image: b != null
                                      ? NetworkImage(b)
                                      : AssetImage('assets/nfound.png'),
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                        UpperToolbar(),
                        Positioned(
                          top: height * 0.28,
                          width: width - 5,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: DetailsAbove(
                              title: movie['title'],
                              runtime: runtime,
                              rating: rating,
                              image: p,
                              genreList: genreList,
                            ),
                          ),
                        ),
                        Positioned(
                          top: height * 0.57,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 20.0, right: 10.0),
                                child: Text(
                                  'Available on: ',
                                  style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                              providers == null
                                  ? Text(
                                      "N/A",
                                      style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.0,
                                      ),
                                    )
                                  : Container(
                                      width: width,
                                      height: 50.0,
                                      //color: Colors.black,

                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: providers.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          String path = providers[index]
                                                  ['logo_path']
                                              .toString();
                                          return Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Image.network(
                                              '$image_url$path',
                                              height: 80.0,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  MovieInfo(k: "Release date:", v: "${movie['release_date']}"),
                  SizedBox(height: 8.0),
                  MovieInfo(k: "Budget:", v: moneyCalculator(movie['budget'])),
                  SizedBox(height: 8.0),
                  MovieInfo(
                      k: "Box Office:", v: moneyCalculator(movie['revenue'])),
                  SizedBox(height: 8.0),
                  MovieInfo(k: "Tagline: ", v: "${movie['tagline']}"),
                  SizedBox(height: 20.0),
                  StoryLine(storyline: movie['overview']),
                  SizedBox(height: 16.0),
                  movie['credits']['cast'].length == null ||
                          movie['credits']['cast'].length == 0
                      ? SizedBox.shrink()
                      : MovieCast(
                          title: "CAST",
                          cast: movie['credits']['cast'],
                          width: width,
                          height: height,
                          desig: false,
                        ),
                  SizedBox(height: 16.0),
                  movie['credits']['crew'].length == null ||
                          movie['credits']['crew'].length == 0
                      ? SizedBox.shrink()
                      : MovieCast(
                          title: "CREW",
                          cast: movie['credits']['crew'],
                          width: width,
                          height: height,
                          desig: true,
                        ),
                  SizedBox(height: 16.0),
                  movie["images"]["backdrops"] == null ||
                          movie["images"]["backdrops"].length == 0
                      ? SizedBox.shrink()
                      : Photos(
                          photos: movie["images"]["backdrops"],
                          width: width,
                          height: height,
                        ),
                  recom == null || recom.length == 0
                      ? SizedBox.shrink()
                      : Category(
                          title: "RECOMMENDATIONS",
                          popularMovies: recom,
                          height: 210,
                          width: 150,
                          home: false,
                        ),
                ],
              ),
            ),
    );
  }
}

class SemiCircle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var roundFactor = 120;
    var path = Path();

    path.lineTo(0, size.height - roundFactor);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - roundFactor);

    // path.lineTo(size.width, size.height - 50.0);
    // path.quadraticBezierTo(size.width - (size.width / 2), size.height / 2,
    //     size.width, size.height);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
