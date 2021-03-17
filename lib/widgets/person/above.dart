import 'package:flutter/material.dart';
import 'package:movietime/api/url.dart';
import 'package:movietime/widgets/person/cast_detail.dart';

class CastAbove extends StatelessWidget {
  //final result;
  final String name, dob, dod, dept, pob, profile;
  final height, width;

  const CastAbove({
    Key key,
    //this.result,
    this.height,
    this.width,
    this.name,
    this.dob,
    this.dod,
    this.dept,
    this.pob,
    this.profile,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: width * 0.17,
              backgroundImage: profile != null
                  ? NetworkImage(
                      '${URLs.imageURL}$profile',
                    )
                  : AssetImage('assets/nfound.png'),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$name',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 22.0,
                        ),
                      ),
                      Text(
                        '$dept',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(height: 18.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CastDetail(
                            height: height,
                            k: "Date of birth: ",
                            v: dob != null
                                ? dob.split('-').reversed.join('-')
                                : "N/A",
                          ),
                          SizedBox(height: 5.0),
                          CastDetail(
                            height: height,
                            k: "Place of birth: ",
                            v: pob != null ? pob : "N/A",
                          ),
                          SizedBox(height: 8.0),
                          dod != null
                              ? CastDetail(
                                  height: height,
                                  k: "Death: ",
                                  v: dod.split('-').reversed.join('-'),
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
