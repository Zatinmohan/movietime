import 'package:flutter/material.dart';
import 'package:movietime/model/colordata.dart';

class DetailsAbove extends StatelessWidget {
  final String title;
  final double rating;
  final String releaseDate;
  final List<String> genreList;
  final String image;

  const DetailsAbove(
      {Key key,
      this.title,
      this.rating,
      this.releaseDate,
      this.genreList,
      this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Row(
      children: [
        Container(
          width: width * 0.35,
          height: height * 0.28,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              )),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: height * 0.07, left: 22.0),
                child: Text(
                  '$title',
                  softWrap: true,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 28.0,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '⭐ ${rating.toString()}',
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      '📅  $releaseDate',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.0),
              Container(
                height: 30.0,
                //color: Colors.black,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: genreList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(left: 15.0, top: 10.0),
                      child: Container(
                        width: 80.0,
                        decoration: BoxDecoration(
                          color: Color(0xffdcdcdc),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(child: Text('${genreList[index]}')),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
