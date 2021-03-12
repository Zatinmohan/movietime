import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:movietime/model/api.dart';
import 'package:movietime/model/colordata.dart';
import 'package:movietime/model/movieModel.dart';
import 'package:movietime/model/movieallDetails.dart';
import 'package:movietime/model/url.dart';
import 'package:movietime/widgets/categories/colrow.dart';
import 'package:movietime/widgets/movie%20details/RowButtons.dart';
import 'package:movietime/model/api_key.dart';
import 'package:movietime/widgets/movie%20details/cast.dart';

import 'package:movietime/widgets/movie%20details/detailLayout.dart';
import 'package:movietime/widgets/movie%20details/movieInfo.dart';
import 'package:movietime/widgets/movie%20details/photos.dart';

import 'package:movietime/widgets/movie%20details/storyline.dart';
import 'package:movietime/widgets/movie%20details/streamServices.dart';

class MovieDetail extends StatefulWidget {
  final int id;

  const MovieDetail({Key key, this.id}) : super(key: key);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  Future<MovieDetailModel> builder;
  Future<MovieModel> recommendation;

  @override
  void initState() {
    super.initState();
    print(widget.id);
    builder = APIManager().getDetails(widget.id.toString());
    recommendation = APIManager().getRecommendation(widget.id.toString());
    print(widget.id);
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
      body: builder == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: FutureBuilder<MovieDetailModel>(
                future: builder,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    String backdrop = snapshot.data.backdropPath;
                    String title = snapshot.data.title;
                    int runtime = snapshot.data.runtime;
                    double rating = snapshot.data.voteAverage;
                    String poster = snapshot.data.posterPath;
                    List<Genre> genre = snapshot.data.genre;
                    //[TO DO!!!] Watchers
                    IN india = snapshot.data.watchProviders.results.india;
                    List<Flatrate> providers;
                    if (india != null)
                      providers =
                          snapshot.data.watchProviders.results.india.flatrate;

                    String releaseDate = snapshot.data.releaseDate;
                    int budget = snapshot.data.budget;
                    int revenue = snapshot.data.revenue;
                    String tagline = snapshot.data.tagline;
                    String overview = snapshot.data.overview;
                    List<Cast> cast = snapshot.data.credits.cast;
                    List<Cast> crew = snapshot.data.credits.crew;
                    List<Backdrop> backdrops = snapshot.data.images.backdrops;
                    return Column(
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
                                        image: backdrop != null
                                            ? NetworkImage(
                                                "${URLs.imageURL}$backdrop")
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: DetailsAbove(
                                    title: title,
                                    runtime: runtime,
                                    rating: rating,
                                    image: poster,
                                    genreList: genre,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: height * 0.57,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 20.0, right: 10.0),
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
                                        : Streaming(
                                            height: height,
                                            width: width,
                                            providers: providers,
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        MovieInfo(
                            k: "Release date:",
                            v: "${releaseDate.split('-').reversed.join('-')}"),
                        SizedBox(height: 8.0),
                        MovieInfo(k: "Budget:", v: moneyCalculator(budget)),
                        SizedBox(height: 8.0),
                        MovieInfo(
                            k: "Box Office:", v: moneyCalculator(revenue)),
                        SizedBox(height: 8.0),
                        MovieInfo(k: "Tagline: ", v: "$tagline"),
                        SizedBox(height: 20.0),
                        StoryLine(
                          storyline: overview,
                          k: "STORYLINE",
                        ),
                        SizedBox(height: 16.0),
                        cast.length == null
                            ? SizedBox.shrink()
                            : MovieCast(
                                title: "CAST",
                                cast: cast,
                                width: width,
                                height: height,
                                desig: false,
                              ),
                        SizedBox(height: 16.0),
                        crew.length == null
                            ? SizedBox.shrink()
                            : MovieCast(
                                title: "CREW",
                                cast: crew,
                                width: width,
                                height: height,
                                desig: true,
                              ),
                        SizedBox(height: 16.0),
                        backdrops.length == 0
                            ? SizedBox.shrink()
                            : Photos(
                                photos: backdrops,
                                width: width,
                                height: height,
                              ),
                        Category(
                          title: "RECOMMENDATIONS",
                          movieBuilder: recommendation,
                          height: 210,
                          width: 150,
                          home: false,
                        ),
                      ],
                    );
                  }
                  return CircularProgressIndicator();
                },
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
