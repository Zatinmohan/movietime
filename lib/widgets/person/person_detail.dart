import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movietime/api/api.dart';
import 'package:movietime/model/castModel.dart';
import 'package:movietime/widgets/misc/appbar.dart';
import 'package:movietime/widgets/movie%20details/photos.dart';
import 'package:movietime/widgets/movie%20details/storyline.dart';
import 'package:movietime/widgets/person/above.dart';

class PersonDetail extends StatefulWidget {
  final String id;
  final width;
  final height;
  PersonDetail({Key key, this.id, this.width, this.height}) : super(key: key);

  @override
  _PersonDetailState createState() => _PersonDetailState();
}

class _PersonDetailState extends State<PersonDetail> {
  Future<CastModel> builder;
  @override
  void initState() {
    builder = APIManager().getPeople(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: widget.width * 0.11),
          child: Text('movietime',
              style: GoogleFonts.fredokaOne(
                color: Color(0xfffb5558),
                fontWeight: FontWeight.w500,
                fontSize: 28.0,
              )),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
            child: FutureBuilder<CastModel>(
          future: builder,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String bio = snapshot.data.biography;
              List<Profiles> images = snapshot.data.images.profiles;
              return Column(
                children: [
                  CastAbove(
                    height: widget.height,
                    width: widget.width,
                    name: snapshot.data.name,
                    dept: snapshot.data.job,
                    dob: snapshot.data.birthday,
                    dod: snapshot.data.deathday,
                    pob: snapshot.data.placeOfBirth,
                    profile: snapshot.data.profilePath,
                  ),
                  SizedBox(height: 10.0),
                  bio != null
                      ? StoryLine(
                          storyline: bio,
                          k: "BIOGRAPHY",
                        )
                      : SizedBox.shrink(),
                  SizedBox(height: 12.0),
                  images != null
                      ? Photos(
                          photos: images,
                          height: widget.height,
                          width: widget.width,
                        )
                      : SizedBox.shrink(),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        )),
      ),
    );
  }
}
