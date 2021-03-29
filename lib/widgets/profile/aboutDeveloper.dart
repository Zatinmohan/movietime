import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movietime/model/colordata.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutDeveloper extends StatelessWidget {
  final width;

  const AboutDeveloper({Key key, this.width}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircleAvatar(
            radius: width * 0.3,
            backgroundImage: AssetImage('assets/dev.jpg'),
          ),
          SizedBox(height: 5.0),
          Text(
            "Jatin Mohan",
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: width * 0.07,
            ),
          ),
          Text(
            "Engineer by day, pimp by night",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: width * 0.035,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(FontAwesomeIcons.facebookF),
                onPressed: () async {
                  if (await canLaunch("https://www.facebook.com/iamzatin")) {
                    launch("https://www.facebook.com/iamzatin");
                  }
                },
              ),
              IconButton(
                icon: Icon(FontAwesomeIcons.instagram),
                onPressed: () async {
                  if (await canLaunch(
                      "https://www.instagram.com/o.my.god.someone_actually/")) {
                    launch(
                        "https://www.instagram.com/o.my.god.someone_actually/");
                  }
                },
              ),
              IconButton(
                icon: Icon(FontAwesomeIcons.linkedin),
                onPressed: () async {
                  if (await canLaunch(
                      "https://www.linkedin.com/in/jatin-mohan/")) {
                    launch("https://www.linkedin.com/in/jatin-mohan/");
                  }
                },
              ),
              IconButton(
                icon: Icon(FontAwesomeIcons.github),
                onPressed: () async {
                  if (await canLaunch("https://github.com/Zatinmohan")) {
                    launch("https://github.com/Zatinmohan");
                  }
                },
              ),
            ],
          )
        ]),
      ),
    );
  }
}
