class MovieModel {
  MovieModel({
    this.results,
  });

  List<Result> results;

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.id,
    this.title,
    this.voteAverage,
    this.posterPath,
    this.releaseDate,
  });

  int id;
  String title;
  double voteAverage;
  String posterPath;
  String releaseDate;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        title: json["title"],
        voteAverage: json["vote_average"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "vote_average": voteAverage,
        "poster_path": posterPath,
        "release_date": releaseDate,
      };
}
