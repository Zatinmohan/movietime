import 'package:flutter/material.dart';
import 'package:movietime/model/colordata.dart';
import 'package:movietime/model/sharedpref.dart';
import 'package:movietime/widgets/movieFinder/search_result.dart';

class Search extends SearchDelegate<String> {
  List<String> movieHistory = [
    "Avengers End Game",
    "X-men Days of Future Past",
  ];
  SharedFiles obj;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () => {close(context, null)});
  }

  @override
  Widget buildResults(BuildContext context) {
    SharedFiles().start();
    if (query != '' && !movieHistory.contains(query)) {
      movieHistory.insert(0, query);
      SharedFiles().setMovies(movieHistory);
    }

    return SearchResult(
      search: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (SharedFiles().checkMovie()) movieHistory = SharedFiles().getMovies();
    return ListView.builder(
      itemCount: movieHistory.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            query = movieHistory[index];
          },
          child: ListTile(
            key: Key(movieHistory.length.toString()),
            leading: Icon(Icons.history),
            title: Text('${movieHistory[index]}',
                style: TextStyle(
                  color: textColor,
                  fontSize: 20.0,
                )),
            trailing: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  movieHistory.removeAt(index);
                  SharedFiles().setMovies(movieHistory);
                }),
          ),
        );
      },
    );
  }
}
