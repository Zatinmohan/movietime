import 'package:flutter/material.dart';
import 'package:movietime/model/colordata.dart';

class Category extends StatelessWidget {
  final popularMovies;
  final double width, height;
  final String url = 'https://image.tmdb.org/t/p/original';
  final String title;
  const Category({
    Key key,
    this.popularMovies,
    this.title,
    this.width,
    this.height,
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
                  fontWeight: FontWeight.w500,
                )),
            Text('Show All',
                style: TextStyle(
                  color: linkText,
                  fontSize: 18.0,
                ))
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          //color: Colors.black,
          height: height + 50.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              String poster = popularMovies[index]['poster_path'];
              String title = popularMovies[index]['title'];
              String rating =
                  '⭐  ' + popularMovies[index]['vote_average'].toString();
              return Container(
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
                          image: DecorationImage(
                            image: NetworkImage('$url$poster'),
                            fit: BoxFit.fill,
                          )),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '$title',
                              style: TextStyle(
                                color: textColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                            ),
                            SizedBox(height: 2.0),
                            Text(
                              '$rating',
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 15.0),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
