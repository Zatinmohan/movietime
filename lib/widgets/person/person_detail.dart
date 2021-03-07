import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

import 'package:movietime/model/api_key.dart';

class PersonDetail extends StatefulWidget {
  final String id;

  const PersonDetail({Key key, this.id}) : super(key: key);

  @override
  _PersonDetailState createState() => _PersonDetailState();
}

class _PersonDetailState extends State<PersonDetail> {
  var result;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var cast = await https.get('https://api.themoviedb.org/3/person/' +
        widget.id +
        '?api_key=' +
        key +
        '&language=en-US');

    result = jsonDecode(cast.body);
    print(result);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('${result["name"]}')),
    );
  }
}
