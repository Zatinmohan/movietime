import 'package:flutter/material.dart';

class FullImage extends StatelessWidget {
  final img;
  const FullImage({Key key, this.img}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: InteractiveViewer(child: Image.network('$img')),
    );
  }
}
