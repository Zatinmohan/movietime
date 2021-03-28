import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movietime/firebase/authentication.dart';
import 'package:movietime/model/colordata.dart';
import 'package:movietime/widgets/misc/appbar.dart';
import 'package:movietime/widgets/misc/navbar.dart';
import 'package:movietime/widgets/movie%20details/movies_all.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:provider/provider.dart';

class SavedMovies extends StatefulWidget {
  @override
  _SavedMoviesState createState() => _SavedMoviesState();
}

class _SavedMoviesState extends State<SavedMovies> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavBar(),
      appBar: CustomAppBar(
        scaffoldKey: _scaffoldKey,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: StreamBuilder<DocumentSnapshot>(
          stream: context.read<AuthenticationServices>().getDataBase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              List<dynamic> savedMovies;
              if (snapshot.hasData) {
                savedMovies = snapshot.data
                    .get('LikedMovies')
                    .entries
                    .map((entry) => entry.value)
                    .toList();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Saved Movies',
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 20.0,
                            ),
                          ),
                          Text(
                            "${savedMovies.length}",
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 20.0,
                            ),
                          ),
                        ]),
                    SizedBox(height: 20.0),
                    savedMovies.length != 0
                        ? Expanded(
                            child: GridView.builder(
                                itemCount: savedMovies.length,
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent:
                                      MediaQuery.of(context).size.width * 0.5,
                                  crossAxisSpacing: 5.0,
                                  mainAxisSpacing: 5.0,
                                  childAspectRatio: 3 / 5.5,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  int id = savedMovies[index]['id'];

                                  String path = savedMovies[index]['image'];
                                  String name = savedMovies[index]['title'];

                                  return MoviesAll(
                                    id: id,
                                    path: path,
                                    name: name,
                                  );
                                }),
                          )
                        : Expanded(
                            child:
                                Center(child: Image.asset('assets/empty.png')),
                          ),
                  ],
                );
              } else {
                return Center(
                    child: Image.asset('assets/search_not_found.png'));
              }
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
