import 'package:flutter/material.dart';
import 'package:movietime/model/colordata.dart';
import 'package:movietime/widgets/movie%20details/moviedetail.dart';

class Category extends StatelessWidget {
  final bool home;
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
    this.home,
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
                ? Text('Show All',
                    style: TextStyle(
                      color: linkText,
                      fontSize: 18.0,
                    ))
                : SizedBox.shrink(),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          //color: Colors.black,
          height: height + 50.0,
          child: popularMovies.length == 0 || popularMovies == null
              ? Image(image: AssetImage('assets/navailable.jpg'))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      popularMovies.length > 7 ? 6 : popularMovies.length,
                  itemBuilder: (BuildContext context, int index) {
                    int id = popularMovies[index]['id'];
                    String poster = popularMovies[index]['poster_path'];
                    String title = popularMovies[index]['title'];
                    String rating;
                    if (home)
                      rating = '⭐  ' +
                          popularMovies[index]['vote_average'].toString();
                    else {
                      rating = popularMovies[index]['release_date'];
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
                ),
        ),
      ]),
    );
  }
}
