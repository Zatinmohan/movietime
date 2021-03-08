import 'package:flutter/material.dart';
import 'package:movietime/widgets/person/cast_detail.dart';

class CastAbove extends StatelessWidget {
  final result;
  final height, width;
  final url = 'https://image.tmdb.org/t/p/original';

  const CastAbove({Key key, this.result, this.height, this.width})
      : super(key: key);
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
              backgroundImage: result['profile_path'] != null
                  ? NetworkImage(
                      '$url${result['profile_path']}',
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
                        '${result['name']}',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 22.0,
                        ),
                      ),
                      Text(
                        '${result['known_for_department']}',
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
                            v: result['birthday'] != null
                                ? result['birthday']
                                    .split('-')
                                    .reversed
                                    .join('-')
                                : "N/A",
                          ),
                          SizedBox(height: 5.0),
                          CastDetail(
                            height: height,
                            k: "Place of birth: ",
                            v: result['place_of_birth'] != null
                                ? result['place_of_birth']
                                : "N/A",
                          ),
                          SizedBox(height: 8.0),
                          result['deathday'] != null
                              ? CastDetail(
                                  height: height,
                                  k: "Death: ",
                                  v: result['deathday']
                                      .split('-')
                                      .reversed
                                      .join('-'),
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
