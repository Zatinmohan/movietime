import 'package:flutter/material.dart';
import 'package:movietime/widgets/appbar.dart';

import '../movie details/moviedetail.dart';

class ShowAll extends StatelessWidget {
  final title, movies;
  final String image_url = 'https://image.tmdb.org/t/p/original';
  //final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ShowAll({Key key, this.title, this.movies}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _scaffoldKey,
      appBar: CustomAppBar(
        scaffoldKey: null,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$title',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 22.0,
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: GridView.builder(
                  itemCount: movies.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 3 / 4.5,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    int id = movies[index]['id'];
                    String path = movies[index]["poster_path"];
                    return GridTile(
                        child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => MovieDetail(id: id))),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Image.network(
                          '$image_url$path',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
