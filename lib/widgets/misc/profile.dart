import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movietime/model/colordata.dart';
import 'package:movietime/widgets/misc/appbar.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.11),
          child: Text('movietime',
              style: GoogleFonts.fredokaOne(
                color: Color(0xfffb5558),
                fontWeight: FontWeight.w500,
                fontSize: 28.0,
              )),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            children: [
              Row(children: [
                CircleAvatar(
                  radius: width * 0.2,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/newuser.png'),
                ),
                SizedBox(width: 12.0),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        'First Last',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 22.0,
                        ),
                        maxLines: 1,
                      ),
                      SizedBox(height: 4.0),
                      AutoSizeText(
                        'email@domail.com',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ]),
              Divider(
                height: 20.0,
                thickness: 2,
              ),
              SizedBox(height: 10.0),
              ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: ListTile.divideTiles(
                  context: context,
                  tiles: [
                    ListTile(
                      leading: Icon(FontAwesomeIcons.key),
                      title: Text(
                        'Reset Password',
                        style: TextStyle(
                          fontSize: 19.0,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(FontAwesomeIcons.handsHelping),
                      title: Text(
                        'About Application',
                        style: TextStyle(
                          fontSize: 19.0,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(FontAwesomeIcons.userAlt),
                      title: Text(
                        'About Developer',
                        style: TextStyle(
                          fontSize: 19.0,
                        ),
                      ),
                    ),
                  ],
                ).toList(),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: width * 0.35,
                    height: 50.0,
                    child: RaisedButton(
                      color: Color(0xffDB4437),
                      onPressed: () => print("Logout"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      textColor: Colors.white,
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
