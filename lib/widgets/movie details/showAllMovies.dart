import 'package:flutter/material.dart';
import 'package:movietime/model/movieModel.dart';
import 'package:movietime/widgets/misc/appbar.dart';
import 'package:movietime/widgets/movie%20details/movies_all.dart';

class ShowAll extends StatelessWidget {
  final title, movies;
  final bool check;

  //final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ShowAll({Key key, this.title, this.movies, this.check}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _scaffoldKey,
      appBar: CustomAppBar(
        scaffoldKey: null,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: FutureBuilder<MovieModel>(
          future: movies,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$title',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 22.0,
                        ),
                      ),
                      Text(
                        '${snapshot.data.results.length}',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Expanded(
                    child: GridView.builder(
                        itemCount: snapshot.data.results.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent:
                              MediaQuery.of(context).size.width * 0.5,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                          childAspectRatio: 3 / 4.8,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          int id = snapshot.data.results[index].id;

                          String path = snapshot.data.results[index].posterPath;
                          String name = snapshot.data.results[index].title;

                          return MoviesAll(
                            path: path,
                            name: name,
                            id: id,
                          );
                        }),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
