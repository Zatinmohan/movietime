import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movietime/model/colordata.dart';
import 'package:movietime/widgets/misc/aboutDetails.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            title: Center(
              child: Padding(
                  padding: EdgeInsets.only(
                    right: width * 0.1,
                  ),
                  child: title),
            )),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AboutDetails(
                title: "VERSION",
                text1: "App version",
                text2: "1.0.0",
                isbutton: false,
              ),
              Divider(
                color: Colors.grey,
                height: 10.0,
                thickness: 1,
              ),
              SizedBox(height: 20.0),
              AboutDetails(
                title: "DISCLAIMER",
                text2:
                    "No sensitive records are stored in our database except user email, name and movies that user have liked.",
                text1: null,
                isbutton: false,
              ),
              Divider(
                color: Colors.grey,
                height: 10.0,
                thickness: 1,
              ),
              SizedBox(height: 20.0),
              AboutDetails(
                title: 'DATA SOURCE',
                text2:
                    'Data shown to you is verified and updated by THE MOVIE DATABASE (TMDB).',
                text1: null,
                isbutton: true,
              ),
              Divider(
                color: Colors.grey,
                height: 10.0,
                thickness: 1,
              ),
              SizedBox(height: 20.0),
              Text(
                "RESOURCES/ PLUGINS",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: width * 0.06,
                  letterSpacing: 1.4,
                ),
              ),
              SizedBox(height: 10.0),
              ReourceWidget(
                title: "Design",
                subtitle: "UI Idea",
                url:
                    "https://www.behance.net/gallery/96923617/Movie-App-Concept?tracking_source=search_projects_recommended%7Cmovie%20app",
                icon: FontAwesomeIcons.uikit,
              ),
              ReourceWidget(
                title: "unDraw",
                subtitle: "Illustrations",
                url: "https://undraw.co/",
                icon: FontAwesomeIcons.paintBrush,
              ),
              ReourceWidget(
                title: "FlatIcons",
                subtitle: "Icons",
                url: "https://www.flaticon.com/",
                icon: FontAwesomeIcons.icons,
              ),
              ReourceWidget(
                title: "Font Awesome Icons",
                subtitle: "Icons",
                url: "https://pub.dev/packages/font_awesome_flutter",
                icon: FontAwesomeIcons.icons,
              ),
              ReourceWidget(
                title: "Firebase",
                subtitle: "Database",
                url: "https://firebase.google.com/",
                icon: FontAwesomeIcons.database,
              ),
              ReourceWidget(
                title: "Google Fonts",
                subtitle: "Fonts plugin",
                url: "https://pub.dev/packages/google_fonts",
                icon: FontAwesomeIcons.font,
              ),
              ReourceWidget(
                title: "URL Provider",
                subtitle: "URL plugin",
                url: "https://pub.dev/packages/http",
                icon: FontAwesomeIcons.sitemap,
              ),
              ReourceWidget(
                title: "Read More",
                subtitle: "Text Plugin",
                url: "https://pub.dev/packages/readmore",
                icon: FontAwesomeIcons.readme,
              ),
              ReourceWidget(
                title: "Shared Preference",
                subtitle: "Application Plugin",
                url: "https://pub.dev/packages/shared_preferences",
                icon: FontAwesomeIcons.share,
              ),
              ReourceWidget(
                title: "Auto Size Text",
                subtitle: "Text Plugin",
                url: "https://pub.dev/packages/auto_size_text",
                icon: FontAwesomeIcons.textWidth,
              ),
              ReourceWidget(
                title: "Optimized Cache Image",
                subtitle: "Image Plugin",
                url: "https://pub.dev/packages/optimized_cached_image",
                icon: FontAwesomeIcons.images,
              ),
              ReourceWidget(
                title: "Provider",
                subtitle: "Application Plugin",
                url: "https://pub.dev/packages/provider",
                icon: FontAwesomeIcons.tools,
              ),
              ReourceWidget(
                title: "URL Launcher",
                subtitle: "Link Share Plugin",
                url: "https://pub.dev/packages/url_launcher",
                icon: FontAwesomeIcons.link,
              ),
              ReourceWidget(
                title: "Share",
                subtitle: "Content Share Plugin",
                url: "https://pub.dev/packages/share",
                icon: FontAwesomeIcons.share,
              ),
            ],
          ),
        )));
  }
}

class ReourceWidget extends StatelessWidget {
  final url, title, subtitle, icon;
  const ReourceWidget({
    Key key,
    this.url,
    this.title,
    this.subtitle,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text("$title"),
      subtitle: Text("$subtitle"),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () async {
        if (await canLaunch("$url")) launch("$url");
      },
    );
  }
}
