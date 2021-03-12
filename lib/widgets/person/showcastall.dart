import 'package:flutter/material.dart';
import 'package:movietime/model/movieallDetails.dart';
import 'package:movietime/widgets/person/cast_all.dart';

import '../misc/appbar.dart';

class ShowCastAll extends StatelessWidget {
  final title;
  final List<Cast> castall;
  final bool isCast;

  const ShowCastAll({Key key, this.title, this.castall, this.isCast})
      : super(key: key);
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
                  '${castall.length}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: GridView.builder(
                  itemCount: castall.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                    childAspectRatio: 3 / 4.8,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    int id = castall[index].id;

                    String path = castall[index].profilePath;

                    String character =
                        !isCast ? castall[index].character : castall[index].job;

                    String name = castall[index].name;

                    return AllCast(
                      path: path,
                      id: id,
                      role: character,
                      name: name,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
