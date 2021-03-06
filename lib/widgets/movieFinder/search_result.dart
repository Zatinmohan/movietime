import 'package:flutter/material.dart';
import 'package:movietime/api/api.dart';
import 'package:movietime/model/colordata.dart';
import 'package:movietime/model/movieModel.dart';
import 'package:movietime/api/url.dart';
import '../movie details/moviedetail.dart';

class SearchResult extends StatefulWidget {
  final String search;

  const SearchResult({Key key, this.search}) : super(key: key);
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  Future<MovieModel> builder;
  @override
  void initState() {
    super.initState();
    builder = APIManager().searchMovies(widget.search);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder<MovieModel>(
        future: builder,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.results.length != 0) {
              return ListView.builder(
                itemCount: snapshot.data.results.length,
                itemBuilder: (BuildContext context, int index) {
                  String name = snapshot.data.results[index].title;
                  String image = snapshot.data.results[index].posterPath;
                  String date = snapshot.data.results[index].releaseDate;
                  int id = snapshot.data.results[index].id;

                  if (date != null)
                    date = date.substring(0, 4);
                  else
                    date = "N/A";

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => MovieDetail(id: id)));
                    },
                    child: ListTile(
                      leading: image == null
                          ? Image.asset('assets/nfound.png')
                          : Image.network(
                              '${URLs.imageURL}$image',
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
              );
            } else
              return Center(child: Image.asset('assets/search_not_found.png'));
          } else if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
                child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xffFB5558))));
          return Container();
        },
      ),
    );
  }
}
