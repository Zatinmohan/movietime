import 'package:flutter/material.dart';
import 'package:movietime/api/url.dart';

class Streaming extends StatelessWidget {
  final height, width, providers;

  const Streaming({Key key, this.height, this.width, this.providers})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      child: providers != null
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: providers.length,
              itemBuilder: (BuildContext context, int index) {
                String path = "${URLs.imageURL}${providers[index].logoPath}";

                return Container(
                  padding: EdgeInsets.all(8.0),
                  child: Image.network(
                    '$path',
                    height: 80.0,
                  ),
                );
              },
            )
          : SizedBox.shrink(),
    );
  }
}
