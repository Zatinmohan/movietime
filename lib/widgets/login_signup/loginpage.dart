import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movietime/firebase/authentication.dart';
import 'package:movietime/model/colordata.dart';

import 'package:movietime/widgets/login_signup/google_facebook.dart';
import 'package:movietime/widgets/login_signup/signup.dart';
import 'package:provider/provider.dart';

import '../../mainpage.dart';

class LoginPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String emailValidator(String value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);

    if (value.isEmpty)
      return "*Required";
    else if (!emailValid) return "*Enter a valid email";
    return null;
  }

  String passwordValidator(String value) {
    if (value.isEmpty) return "*Required";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: height * 0.18),
              Center(
                child: Text(
                  'Welcome to Movietime!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: width * 0.085,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              Center(
                child: Text(
                  'Your personal guide to the world of cinema',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: width * 0.042,
                  ),
                ),
              ),
              SizedBox(height: height * 0.1),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      validator: emailValidator,
                      decoration: InputDecoration(
                        hintText: 'Email, phone number, username',
                        filled: true,
                        fillColor: bgTextFieldColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 25.0),
                    TextFormField(
                      controller: _passwordController,
                      validator: passwordValidator,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        filled: true,
                        fillColor: bgTextFieldColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14.0),
              Text(
                'Forget your password?',
                style: TextStyle(
                  color: linkText,
                  fontSize: width * 0.044,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 25.0),
              Builder(
                builder: (context) => Center(
                  child: Container(
                    width: width * 0.8,
                    height: 55,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      color: logoColor,
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 7),
                              content: Row(
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(width: 16.0),
                                  Text('Signing-in'),
                                ],
                              )));
                          context
                              .read<AuthenticationServices>()
                              .signIn(
                                username: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              )
                              .timeout(const Duration(seconds: 20),
                                  onTimeout: () {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text("Network Issue!")));
                            return "true";
                          }).then((value) {
                            print(value);
                            if (value == 'user-not-found')
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("User not registered")));
                            else if (value == 'wrong-password')
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("Password incorrect!")));
                            else if (value == 'Successful')
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => MainPage()));
                            else
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text("Network Issue!")));
                          });
                        }
                      },
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.08),
              GoogleFacebook(
                width: width,
                loginContext: context,
              ),
              SizedBox(height: 32.0),
              Align(
                alignment: Alignment.bottomCenter,
                child: Center(
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: width * 0.044,
                        )),
                    TextSpan(
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Signup(
                                        width: width,
                                        height: height,
                                      ))),
                        text: "SIGN UP",
                        style: TextStyle(
                          color: linkText,
                          fontSize: width * 0.044,
                          fontWeight: FontWeight.w500,
                        )),
                  ])),
                ),
              ),
            ]),
          ),
        ),
      ),
    ));
  }
}
