import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

import 'package:movietime/model/api_key.dart';
import 'package:movietime/widgets/misc/appbar.dart';
import 'package:movietime/widgets/movie%20details/photos.dart';
import 'package:movietime/widgets/movie%20details/storyline.dart';
import 'package:movietime/widgets/person/above.dart';

class PersonDetail extends StatefulWidget {
  final String id;
  final width;
  final height;
  PersonDetail({Key key, this.id, this.width, this.height}) : super(key: key);

  @override
  _PersonDetailState createState() => _PersonDetailState();
}

class _PersonDetailState extends State<PersonDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
        '&language=en-US&append_to_response=images');

    result = jsonDecode(cast.body);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        scaffoldKey: _scaffoldKey,
      ),
      body: result == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
              children: [
                CastAbove(
                  height: widget.height,
                  width: widget.width,
                  result: result,
                ),
                SizedBox(height: 10.0),
                result["biography"] != null
                    ? StoryLine(
                        storyline: result["biography"],
                        k: "BIOGRAPHY",
                      )
                    : SizedBox.shrink(),
                SizedBox(height: 12.0),
                result["images"]["profiles"] != null
                    ? Photos(
                        photos: result["images"]["profiles"],
                        height: widget.height,
                        width: widget.width,
                      )
                    : SizedBox.shrink(),
              ],
            )),
    );
  }
}
