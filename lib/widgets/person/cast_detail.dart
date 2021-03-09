import 'package:flutter/material.dart';

class CastDetail extends StatelessWidget {
  final height;
  final k, v;

  const CastDetail({Key key, this.height, this.k, this.v}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
            text: "$k",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: height * 0.025,
            )),
        TextSpan(
            text: "$v",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: height * 0.023,
            ))
      ]),
    );
  }
}
