import 'package:flutter/material.dart';
import 'package:movietime/model/colordata.dart';

import '../misc/image_view.dart';

class Photos extends StatelessWidget {
  final url = "https://image.tmdb.org/t/p/original";
  final photos;
  final width, height;
  const Photos({Key key, this.photos, this.width, this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'PHOTOS',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        Container(
            height: height * 0.3,
            //color: Colors.black,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: photos.length > 5 ? 5 : photos.length,
              itemBuilder: (BuildContext context, int index) {
                String img = photos[index]["file_path"];
                return Padding(
                  padding:
                      EdgeInsets.only(right: 20.0, top: 20.0, bottom: 20.0),
                  child: GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => FullImage(img: img))),
                    child: Container(
                      width: width * 0.7,
                      decoration: BoxDecoration(
                        //color: Colors.blue,
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image: NetworkImage('$url$img'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            )),
      ]),
    );
  }
}
