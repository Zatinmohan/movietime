import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movietime/model/colordata.dart';

import '../../model/api_key.dart';
import '../movie details/moviedetail.dart';

class SearchResult extends StatefulWidget {
  final String search;

  const SearchResult({Key key, this.search}) : super(key: key);
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  //typedef AppBar AppBarCallback(BuildContext context);
  var result;
  final url = "https://api.themoviedb.org/3/search/movie?api_key=";
  final iURL = "https://image.tmdb.org/t/p/original";

  @override
  void initState() {
    fetchData();

    super.initState();
  }

  fetchData() async {
    var r = await http.get(url +
        key +
        '&language=en-US&page=1&include_adult=true&query=' +
        widget.search);
    result = jsonDecode(r.body)['results'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return result == null
        ? Center(child: CircularProgressIndicator())
        : new Material(
            child: ListView.builder(
                  itemCount: result.length,
                  itemBuilder: (BuildContext context, int index) {
                    String name = result[index]['title'];
                    String image = result[index]['poster_path'];

                    String date = result[index]['release_date'];
                    int id = result[index]['id'];

                    if (date != null || date.length >= 1)
                      date = date.substring(0, 4);
                    else
                      date = "N/A";
                    // print("LENGTH: ${result.length}}");
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => MovieDetail(id: id)));
                      },
                      child: ListTile(
                        leading: image == null || image.length == 0
                            ? Image.asset('assets/nfound.png')
                            : Image.network(
                                '$iURL$image',
                              ),
                        title: Text(
                          '$name',
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text('$date',
                            style: TextStyle(
                              color: Colors.grey,
                            )),
                      ),
                    );
                  },
                ) ??
                [],
          );
  }
}
