import 'package:flutter/material.dart';
import 'package:movietime/model/colordata.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutDetails extends StatelessWidget {
  final title, text1, text2, isbutton;

  const AboutDetails(
      {Key key, this.title, this.text1, this.text2, this.isbutton})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
            letterSpacing: 1.4,
          ),
        ),
        SizedBox(height: 5.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            text1 != null
                ? Text(
                    "$text1",
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                    ),
                  )
                : SizedBox.shrink(),
            text2 != null
                ? Flexible(
                    child: Text(
                      "$text2",
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
        SizedBox(height: 8.0),
        isbutton
            ? OutlineButton(
                color: Colors.white,
                borderSide: BorderSide(
                  color: logoColor,
                ),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                onPressed: () async {
                  if (await canLaunch("https://www.themoviedb.org/"))
                    await launch("https://www.themoviedb.org/");
                },
                child: Text(
                  "Visit TMDB",
                  style: TextStyle(color: textColor),
                ))
            : SizedBox.shrink(),
      ],
    );
  }
}
