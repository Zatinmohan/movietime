import 'package:flutter/material.dart';
import 'package:movietime/model/colordata.dart';
import 'package:readmore/readmore.dart';

class StoryLine extends StatelessWidget {
  final String storyline;

  const StoryLine({Key key, this.storyline}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'STORYLINE',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 8.0),
        ReadMoreText(
          '$storyline',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18.0,
          ),
          trimLines: 4,
          trimCollapsedText: 'Show more',
          trimExpandedText: 'Show less',
          trimMode: TrimMode.Line,
        )
      ]),
    );
  }
}
