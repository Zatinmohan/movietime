import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movietime/firebase/authentication.dart';
import 'package:movietime/model/colordata.dart';
import 'package:movietime/widgets/login_signup/loginpage.dart';
import 'package:movietime/widgets/misc/aboutApplication.dart';
import 'package:movietime/widgets/movie%20details/savedMovies.dart';
import 'package:provider/provider.dart';

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder<DocumentSnapshot>(
                stream: context.read<AuthenticationServices>().getDataBase(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      String name = snapshot.data.get('name');
                      String email = snapshot.data.get('email');

                      return Row(children: [
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
                                name == null ? 'Unknwon' : '$name',
                                style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22.0,
                                ),
                                maxLines: 1,
                              ),
                              SizedBox(height: 4.0),
                              AutoSizeText(
                                email == null ? 'N/A' : '$email',
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
                      ]);
                    } else {
                      return Container();
                    }
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
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
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      leading: CircleAvatar(
                          backgroundColor: Color(0xfff4fa9c),
                          child: Icon(
                            FontAwesomeIcons.key,
                            color: Color(0xfff3558e),
                          )),
                      title: Text(
                        'Reset Password',
                        style: TextStyle(
                          fontSize: width * 0.055,
                        ),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      leading: CircleAvatar(
                          backgroundColor: Color(0xfff5f5f5),
                          child: Icon(
                            Icons.movie,
                            color: Color(0xffd72323),
                          )),
                      title: Text(
                        'Saved Movies',
                        style: TextStyle(
                          fontSize: width * 0.055,
                        ),
                      ),
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => SavedMovies())),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      leading: CircleAvatar(
                          backgroundColor: Color(0xffa7ff83),
                          child: Icon(FontAwesomeIcons.handsHelping)),
                      title: Text(
                        'About Application',
                        style: TextStyle(
                          fontSize: width * 0.055,
                        ),
                      ),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => AboutApplication())),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      leading: CircleAvatar(
                          backgroundColor: Color(0xfff0f0f0),
                          child: Icon(
                            FontAwesomeIcons.userAlt,
                            color: Color(0xff575151),
                          )),
                      title: Text(
                        'About Developer',
                        style: TextStyle(
                          fontSize: width * 0.055,
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
                      onPressed: () => context
                          .read<AuthenticationServices>()
                          .signOut()
                          .whenComplete(() => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => LoginPage()),
                              )),
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
