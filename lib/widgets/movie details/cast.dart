import 'package:flutter/material.dart';
import 'package:movietime/model/colordata.dart';
import 'package:movietime/model/movieallDetails.dart';
import 'package:movietime/api/url.dart';
import 'package:movietime/widgets/person/showcastall.dart';
import 'package:movietime/widgets/person/person_detail.dart';

class MovieCast extends StatelessWidget {
  final width, height, title;
  final bool desig;
  final List<Cast> cast;

  const MovieCast(
      {Key key, this.cast, this.width, this.height, this.desig, this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$title',
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                  letterSpacing: 1.2,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ShowCastAll(
                                isCast: desig,
                                title: title,
                                castall: cast,
                              )));
                },
                child: Text('See All',
                    style: TextStyle(
                      color: linkText,
                      fontSize: 18.0,
                    )),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Container(
            height: desig ? 180 : 140,
            //color: Colors.black,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cast.length > 5 ? 5 : cast.length,
              itemBuilder: (BuildContext context, int index) {
                String name = cast[index].name;
                String img = cast[index].profilePath;
                String id = cast[index].id.toString();
                String job = cast[index].job;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => PersonDetail(
                                  id: id,
                                  height: height,
                                  width: width,
                                )));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    //color: Colors.blue,
                    width: 100,

                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 32.0,
                              backgroundImage: img != null
                                  ? NetworkImage(
                                      '${URLs.imageURL}$img',
                                    )
                                  : AssetImage(
                                      'assets/user.png',
                                    ),
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Flexible(
                            child: Text(
                              '$name',
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          desig
                              ? Text(
                                  "$job",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0,
                                  ),
                                )
                              : SizedBox.shrink(),
                        ]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
