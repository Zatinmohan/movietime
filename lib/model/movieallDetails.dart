class MovieDetailModel {
  MovieDetailModel({
    this.backdropPath,
    this.budget,
    this.genre,
    this.id,
    this.posterPath,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.tagline,
    this.title,
    this.voteAverage,
    this.credits,
    //this.watchProviders,
    this.images,
    this.overview,
  });

  String overview;
  String backdropPath;
  int budget;
  List<Genre> genre;
  int id;
  String posterPath;
  String releaseDate;
  int revenue;
  int runtime;
  String tagline;
  String title;
  double voteAverage;
  Credits credits;
  //WatchProviders watchProviders;
  Images images;

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) =>
      MovieDetailModel(
        overview: json["overview"],
        backdropPath: json["backdrop_path"],
        budget: json["budget"],
        genre: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        id: json["id"],
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        revenue: json["revenue"],
        runtime: json["runtime"],
        tagline: json["tagline"],
        title: json["title"],
        voteAverage: json["vote_average"].toDouble(),
        credits: Credits.fromJson(json["credits"]),
        //watchProviders: WatchProviders.fromJson(json["watch/providers"]),
        images: Images.fromJson(json["images"]),
      );

  Map<String, dynamic> toJson() => {
        "overview": overview,
        "backdrop_path": backdropPath,
        "budget": budget,
        "genre": List<dynamic>.from(genre.map((x) => x.toJson())),
        "id": id,
        "poster_path": posterPath,
        "release_date": releaseDate,
        "revenue": revenue,
        "runtime": runtime,
        "tagline": tagline,
        "title": title,
        "vote_average": voteAverage,
        "credits": credits.toJson(),
        //"watch/providers": watchProviders.toJson(),
        "images": images.toJson(),
      };
}

class Credits {
  Credits({
    this.cast,
    this.crew,
  });

  List<Cast> cast;
  List<Cast> crew;

  factory Credits.fromJson(Map<String, dynamic> json) => Credits(
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
        "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
      };
}

class Cast {
  Cast({
    this.id,
    this.name,
    this.profilePath,
    this.character,
    this.job,
  });

  int id;
  String name;
  String profilePath;
  String character;
  String job;

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        id: json["id"],
        name: json["name"],
        profilePath: json["profile_path"],
        character: json["character"] == null ? null : json["character"],
        job: json["job"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "profile_path": profilePath,
        "character": character == null ? null : character,
      };
}

class Genre {
  Genre({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Images {
  Images({
    this.backdrops,
  });

  List<Backdrop> backdrops;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        backdrops: List<Backdrop>.from(
            json["backdrops"].map((x) => Backdrop.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "backdrops": List<dynamic>.from(backdrops.map((x) => x.toJson())),
      };
}

class Backdrop {
  Backdrop({
    this.filePath,
  });

  String filePath;

  factory Backdrop.fromJson(Map<String, dynamic> json) => Backdrop(
        filePath: json["file_path"],
      );

  Map<String, dynamic> toJson() => {
        "file_path": filePath,
      };
}

// class WatchProviders {
//   WatchProviders({
//     this.results,
//   });

//   Results results;

//   factory WatchProviders.fromJson(Map<String, dynamic> json) => WatchProviders(
//         results: Results == null ? null : Results.fromJson(json["results"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "results": results != null ? results.toJson() : null,
//       };
// }

// class Results {
//   Results({
//     this.us,
//   });

//   Us us;

//   factory Results.fromJson(Map<String, dynamic> json) =>
//       Results(us: Us == null ? null : Us.fromJson(json["US"]));

//   Map<String, dynamic> toJson() => {
//         "US": us == null ? null : us.toJson(),
//       };
// }

// class Us {
//   Us({
//     this.flatrate,
//   });

//   List<Flatrate> flatrate;

//   factory Us.fromJson(Map<String, dynamic> json) => Us(
//         flatrate: json["flatrate"].length != 0
//             ? List<Flatrate>.from(
//                 json["flatrate"].map((x) => Flatrate.fromJson(x)))
//             : null,
//       );

//   Map<String, dynamic> toJson() => {
//         "flatrate": flatrate.length != 0
//             ? List<dynamic>.from(flatrate.map((x) => x.toJson()))
//             : null,
//       };
// }

// class Flatrate {
//   Flatrate({
//     this.logoPath,
//   });

//   String logoPath;

//   factory Flatrate.fromJson(Map<String, dynamic> json) => Flatrate(
//         logoPath: json["logo_path"],
//       );

//   Map<String, dynamic> toJson() => {
//         "logo_path": logoPath,
//       };
// }
