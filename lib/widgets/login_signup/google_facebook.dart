import 'package:flutter/material.dart';
import 'package:movietime/firebase/authentication.dart';
import 'package:movietime/mainpage.dart';
import 'package:provider/provider.dart';

class GoogleFacebook extends StatelessWidget {
  final width;
  final loginContext;

  const GoogleFacebook({Key key, this.width, this.loginContext})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'or continue with:',
            style: TextStyle(
              color: Colors.grey,
              fontSize: width * 0.045,
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   height: 48.0,
              //   child: RaisedButton.icon(
              //     icon: Icon(
              //       FontAwesomeIcons.facebookF,
              //       color: Colors.white,
              //     ),
              //     label: Text(
              //       'Facebook',
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontSize: width * 0.044,
              //       ),
              //     ),
              //     color: Color(0xff3b5998),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(20.0),
              //     ),
              //     onPressed: () => print("Facebook"),
              //   ),
              // ),
              // SizedBox(width: 20.0),
              Container(
                height: 48.0,
                child: RaisedButton.icon(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  icon: Image.asset(
                    'assets/google.png',
                    height: 28.0,
                  ),
                  label: Text(
                    'Google',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: width * 0.045,
                    ),
                  ),
                  onPressed: () {
                    context
                        .read<AuthenticationServices>()
                        .signInWithGoogle()
                        .then((value) {
                      if (value == "Successful") {
                        Navigator.push(loginContext,
                            MaterialPageRoute(builder: (_) => MainPage()));
                      } else if (value == "Already Exist")
                        Scaffold.of(loginContext).showSnackBar(SnackBar(
                            content: Text("Email Already Registered")));
                      else if (value == "Invalid Credentials")
                        Scaffold.of(loginContext).showSnackBar(
                            SnackBar(content: Text("Invalid Credentials")));
                      else
                        Scaffold.of(loginContext).showSnackBar(SnackBar(
                            content: Text("Network Error! Try Again")));
                    });
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
