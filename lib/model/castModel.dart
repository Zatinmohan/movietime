import 'package:movietime/model/movieallDetails.dart';

class CastModel extends Cast {
  CastModel({
    id,
    name,
    profilePath,
    character,
    this.birthday,
    this.deathday,
    this.placeOfBirth,
    this.biography,
    this.images,
    this.job,
  }) : super(
          id: id,
          name: name,
          character: character,
          profilePath: profilePath,
        );

  String birthday;
  String deathday;
  String placeOfBirth;
  String biography;
  String job;
  Images images;

  factory CastModel.fromJson(Map<String, dynamic> json) => CastModel(
        id: json["id"],
        name: json["name"],
        birthday: json["birthday"],
        deathday: json["deathday"],
        biography: json["biography"],
        placeOfBirth: json["place_of_birth"],
        profilePath: json["profile_path"],
        character: json["character"],
        images: Images.fromJson(json["images"]),
        job: json["known_for_department"],
      );
}

class Images {
  Images({
    this.profiles,
  });
  List<Profiles> profiles;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        profiles: List<Profiles>.from(
            json["profiles"].map((x) => Profiles.fromJson(x))),
      );
}

class Profiles {
  Profiles({
    this.filePath,
  });

  String filePath;

  factory Profiles.fromJson(Map<String, dynamic> json) => Profiles(
        filePath: json["file_path"],
      );
}
