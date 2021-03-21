import 'package:flutter/material.dart';
import 'package:movietime/model/colordata.dart';
import 'package:movietime/model/movieModel.dart';
import 'package:movietime/api/url.dart';
import 'package:movietime/widgets/movie%20details/showAllMovies.dart';
import 'package:movietime/widgets/movie%20details/moviedetail.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';

class Category extends StatelessWidget {
  final bool home;
  final Future<MovieModel> movieBuilder;
  final double width, height;
  final String title;

  const Category({
    Key key,
    this.title,
    this.width,
    this.height,
    this.home,
    this.movieBuilder,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.blue,
      height: 350,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$title',
                style: TextStyle(
                  color: textColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w900,
                )),
            home
                ? GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ShowAll(
                                  title: title,
                                  movies: movieBuilder,
                                  check: true,
                                ))),
                    child: Text('Show All',
                        style: TextStyle(
                          color: linkText,
                          fontSize: 18.0,
                        )),
                  )
                : SizedBox.shrink(),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          //color: Colors.black,
          height: height + 50.0,
          child: FutureBuilder<MovieModel>(
            future: movieBuilder,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData && snapshot.data.results.length != 0) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.results.length >= 6
                        ? 6
                        : snapshot.data.results.length,
                    itemBuilder: (BuildContext context, int index) {
                      int id = snapshot.data.results[index].id;
                      String poster = snapshot.data.results[index].posterPath;
                      String title = snapshot.data.results[index].title;
                      String rating;
                      if (home)
                        rating = '⭐  ' +
                            snapshot.data.results[index].voteAverage.toString();
                      else {
                        rating = snapshot.data.results[index].releaseDate;
                        rating = rating.substring(0, 4);
                      }

                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => MovieDetail(id: id))),
                        child: Container(
                          width: width,
                          child: Stack(
                            children: [
                              Container(
                                height: height,
                                margin: EdgeInsets.only(right: 16.0, top: 5.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.0),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0.0, 3.0),
                                      blurRadius: 6.0,
                                      color: Colors.black26,
                                    ),
                                  ],
                                ),
                                child: poster != null
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: OptimizedCacheImage(
                                          imageUrl: '${URLs.imageURL}$poster',
                                          width: width,
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : Image.asset('assets/nfound.png'),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        '$title',
                                        style: TextStyle(
                                          color: textColor,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                      ),
                                      SizedBox(height: 3.0),
                                      Text(
                                        '$rating',
                                        style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 15.0),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }

              return Image.asset(
                'assets/navailable.jpg',
                scale: 4.0,
              );
            },
          ),
        ),
      ]),
    );
  }
}
