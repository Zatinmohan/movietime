import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoogleFacebook extends StatelessWidget {
  final width;

  const GoogleFacebook({Key key, this.width}) : super(key: key);
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
              Container(
                height: 48.0,
                child: RaisedButton.icon(
                  icon: Icon(
                    FontAwesomeIcons.facebookF,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Facebook',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.044,
                    ),
                  ),
                  color: Color(0xff3b5998),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  onPressed: () => print("Facebook"),
                ),
              ),
              SizedBox(width: 20.0),
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
                  onPressed: () => print("Google"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
