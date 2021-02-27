import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UpperToolbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 30.0,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ),
        Row(
          children: [
            IconButton(
                icon: Icon(
                  FontAwesomeIcons.heart,
                  color: Colors.white,
                ),
                onPressed: () => print("Liked")),
            IconButton(
                icon: Icon(
                  Icons.more_vert_outlined,
                  color: Colors.white,
                ),
                onPressed: () => print("option"))
          ],
        ),
      ],
    );
  }
}
