import 'package:flutter/material.dart';
import 'package:movietime/model/colordata.dart';
import 'package:movietime/model/movieallDetails.dart';
import 'package:movietime/model/url.dart';

class DetailsAbove extends StatelessWidget {
  final String title;
  final double rating;
  final int runtime;
  final List<Genre> genreList;
  final String image;

  const DetailsAbove(
      {Key key,
      this.title,
      this.rating,
      this.runtime,
      this.genreList,
      this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Row(
      children: [
        Container(
          width: width * 0.35,
          height: height * 0.28,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                image: image == null
                    ? AssetImage('assets/nfound.png')
                    : NetworkImage("${URLs.imageURL}$image"),
                fit: BoxFit.cover,
              )),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetTitle(height: height, title: title),
              SizedBox(height: 8.0),
              WidgetDetail(rating: rating, runtime: runtime),
              SizedBox(height: 4.0),
              WidgetGenre(genreList: genreList),
            ],
          ),
        )
      ],
    );
  }
}

class WidgetTitle extends StatelessWidget {
  const WidgetTitle({
    Key key,
    @required this.height,
    @required this.title,
  }) : super(key: key);

  final double height;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: height * 0.07, left: 22.0),
      child: Text(
        '$title',
        softWrap: true,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
          fontSize: 28.0,
        ),
      ),
    );
  }
}

class WidgetDetail extends StatelessWidget {
  const WidgetDetail({
    Key key,
    @required this.rating,
    @required this.runtime,
  }) : super(key: key);

  final double rating;
  final int runtime;
  final String notAvailable = "N/A";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            rating != null ? '⭐ ${rating.toString()}' : '⭐ $notAvailable',
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 16.0,
            ),
          ),
          Text(
            runtime != null ? '⏱️ $runtime min' : '⏱️ $notAvailable',
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.blueGrey,
            ),
          ),
        ],
      ),
    );
  }
}

class WidgetGenre extends StatelessWidget {
  const WidgetGenre({
    Key key,
    @required this.genreList,
  }) : super(key: key);

  final List<Genre> genreList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      //color: Colors.black,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genreList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(left: 15.0, top: 10.0),
            child: Container(
              width: 80.0,
              decoration: BoxDecoration(
                color: Color(0xffdcdcdc),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(child: Text('${genreList[index].name}')),
            ),
          );
        },
      ),
    );
  }
}
