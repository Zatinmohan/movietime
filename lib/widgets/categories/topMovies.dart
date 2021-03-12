import 'package:flutter/material.dart';
import 'package:movietime/model/movieModel.dart';
import 'package:movietime/model/url.dart';

import '../movie details/moviedetail.dart';

class TopMix extends StatelessWidget {
  final Future<MovieModel> movieBuilder;
  final PageController _controller =
      PageController(initialPage: 0, viewportFraction: 0.9);

  TopMix({Key key, this.movieBuilder}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      //color: Colors.black,
      height: MediaQuery.of(context).size.width * 0.80,
      width: double.infinity,
      child: FutureBuilder<MovieModel>(
        future: movieBuilder,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PageView.builder(
                controller: _controller,
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  String poster = snapshot.data.results[index].posterPath;
                  int id = snapshot.data.results[index].id;
                  return GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => MovieDetail(id: id))),
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0.0, 3.0),
                              blurRadius: 6.0,
                              color: Colors.black26,
                            )
                          ],
                          image: DecorationImage(
                            image: NetworkImage('${URLs.imageURL}$poster'),
                            fit: BoxFit.fill,
                          )),
                    ),
                  );
                });
          }
          return Container();
        },
      ),
    );
  }
}
