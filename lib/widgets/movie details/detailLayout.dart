import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:movietime/model/colordata.dart';
import 'package:movietime/model/movieallDetails.dart';
import 'package:movietime/api/url.dart';
import 'package:movietime/widgets/movie%20details/streamServices.dart';
import 'package:optimized_cached_image/widgets.dart';

class DetailsAbove extends StatelessWidget {
  final String title;
  final double rating;
  final int runtime;
  final List<Genre> genreList;
  final String image;
  final providers;

  const DetailsAbove(
      {Key key,
      this.title,
      this.rating,
      this.runtime,
      this.genreList,
      this.image,
      this.providers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Row(
      children: [
        Container(
          width: width * 0.38,
          height: height * 0.32,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: image == null
                ? Image.asset(
                    'assets/nfound.png',
                    fit: BoxFit.cover,
                  )
                : OptimizedCacheImage(
                    imageUrl: '${URLs.imageURL}$image',
                    fit: BoxFit.cover,
                  ),
          ),
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
              SizedBox(height: 5.0),
              providers != null
                  ? Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            'Available on: ',
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        SizedBox(width: 3.0),
                        Flexible(
                          child: Streaming(
                            height: height,
                            width: width,
                            providers: providers,
                          ),
                        )
                      ],
                    )
                  : SizedBox.shrink(),
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
      child: AutoSizeText(
        '$title',
        softWrap: true,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
          fontSize: 28.0,
        ),
        maxLines: 3,
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
