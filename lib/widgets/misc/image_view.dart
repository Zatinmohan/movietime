import 'package:flutter/material.dart';

class FullImage extends StatelessWidget {
  final img;
  final url = "https://image.tmdb.org/t/p/original";
  const FullImage({Key key, this.img}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: InteractiveViewer(child: Image.network('$url$img')),
    );
  }
}
