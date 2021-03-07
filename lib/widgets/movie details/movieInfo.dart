import 'package:flutter/material.dart';

class MovieInfo extends StatelessWidget {
  final String k, v;
  const MovieInfo({Key key, this.k, this.v}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Text(
            '$k ',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
            ),
          ),
          Flexible(
            child: Text(
              '$v',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
