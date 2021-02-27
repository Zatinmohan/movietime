import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:movietime/model/colordata.dart';
import 'package:movietime/widgets/RowButtons.dart';
import 'package:movietime/widgets/api_key.dart';
import 'package:movietime/widgets/detailLayout.dart';

class MovieDetail extends StatefulWidget {
  final int id;

  const MovieDetail({Key key, this.id}) : super(key: key);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  var res, movie;
  String image_url = 'https://image.tmdb.org/t/p/original';
  double rating;
  List<String> genreList = new List();
  String releaseDate;
  String p, b;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    res = await https.get('https://api.themoviedb.org/3/movie/' +
        widget.id.toString() +
        '?api_key=' +
        key +
        '&language=en-US');
    movie = jsonDecode(res.body);
    String poster = movie['poster_path'];
    String backdrop = movie['backdrop_path'];
    p = image_url + poster;
    b = image_url + backdrop;
    rating = movie['vote_average'];
    releaseDate = movie['release_date'];

    var genre = movie['genres'];
    for (int i = 0; i < genre.length; i++) {
      genreList.add(genre[i]['name'].toString());
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: p == null || b == null
          ? CircularProgressIndicator()
          : SingleChildScrollView(
              child: Column(
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
                                  image: NetworkImage(b),
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
                              releaseDate: releaseDate,
                              rating: rating,
                              image: p,
                              genreList: genreList,
                            ),
                          ),
                        ),
                      ],
                    ),
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
