import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movietime/firebase/authentication.dart';
import 'package:movietime/model/colordata.dart';
import 'package:movietime/widgets/login_signup/loginpage.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  final width, height;
  Signup({Key key, this.width, this.height}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _retypePasswordController = TextEditingController();

  String nameValidator(String value) {
    if (value.isEmpty)
      return "*Required";
    else if (value.length < 3) return "Enter a valid name";
    return null;
  }

  String emailValidator(String value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (value.isEmpty)
      return "*Required";
    else if (value.length < 3 || !emailValid) return "Enter a valid email";
    return null;
  }

  String passwordValidator(String value) {
    if (value.isEmpty)
      return "*Required";
    else if (value.length < 5) return "Weak password";
    return null;
  }

  String retypePasswordValidator(String value) {
    if (value == _passwordController.text) return null;
    return "Password do not match";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              IconButton(
                  icon: Icon(
                    FontAwesomeIcons.arrowLeft,
                    color: logoColor,
                  ),
                  onPressed: () => Navigator.pop(context)),
              SizedBox(height: widget.height * 0.06),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Create\n",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: widget.width * 0.13,
                      )),
                  TextSpan(
                      text: "Account",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: widget.width * 0.13,
                      )),
                ]),
              ),
              SizedBox(height: 20.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: nameValidator,
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        filled: true,
                        fillColor: bgTextFieldColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      validator: emailValidator,
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        filled: true,
                        fillColor: bgTextFieldColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
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
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _retypePasswordController,
                      validator: retypePasswordValidator,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Retype Password',
                        filled: true,
                        fillColor: bgTextFieldColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 35.0),
                    Builder(
                      builder: (context) => Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: widget.width * 0.8,
                          height: 55,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            color: logoColor,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    duration: Duration(seconds: 10),
                                    content: Row(
                                      children: [
                                        CircularProgressIndicator(),
                                        SizedBox(width: 10.0),
                                        Text('Please Wait'),
                                      ],
                                    )));
                                context
                                    .read<AuthenticationServices>()
                                    .signUp(
                                      username: _emailController.text.trim(),
                                      name: _nameController.text.trim(),
                                      password: _passwordController.text.trim(),
                                    )
                                    .then((value) {
                                  if (value == "Successful") {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => LoginPage()));
                                  } else
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text(
                                            "Unkown Error! Try again after sometime")));
                                });
                              }
                            },
                            child: Text(
                              'SIGN UP',
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
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
