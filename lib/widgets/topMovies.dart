import 'package:flutter/material.dart';

class TopMix extends StatelessWidget {
  final movieList;
  final PageController _controller =
      PageController(initialPage: 0, viewportFraction: 0.9);
  final String url = 'https://image.tmdb.org/t/p/original';

  TopMix({Key key, this.movieList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      //color: Colors.black,
      height: MediaQuery.of(context).size.width * 0.75,
      width: double.infinity,
      child: PageView.builder(
          controller: _controller,
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            String poster = movieList[index]['poster_path'];
            return Container(
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
                    image: NetworkImage('$url$poster'),
                    fit: BoxFit.fill,
                  )),
            );
          }),
    );
  }
}
