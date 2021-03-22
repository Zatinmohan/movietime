import 'package:movietime/api/api_key.dart';

class URLs {
  static String _baseURL = "https://api.themoviedb.org/3/";
  static String imageURL = "https://image.tmdb.org/t/p/original";
  static String _apiField = "?api_key=";

  static String _trendingURL =
      "https://api.themoviedb.org/3/trending/movie/day?api_key=";
  static String _popularURL =
      "https://api.themoviedb.org/3/movie/popular?api_key=";
  static String _nowPlaying =
      "https://api.themoviedb.org/3/movie/now_playing?api_key=";
  static String _upcoming =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=";
  static String _popularPeople =
      "https://api.themoviedb.org/3/person/popular?api_key=";

  static String getRecommendation(String id) {
    return _baseURL +
        "movie/" +
        id +
        "/recommendations" +
        _apiField +
        key +
        "&language=en-US&page=1";
  }

  static String getMoviesURL(String id) {
    return _baseURL +
        "movie/" +
        id +
        _apiField +
        key +
        "&append_to_response=credits,watch/providers,images";
  }

  static String getTrendingURL() {
    return _trendingURL + key;
  }

  static String getPopularURL() {
    return _popularURL + key + "&language=en-US&page=1";
  }

  static String getNowPlayingURL() {
    return _nowPlaying + key + "&language=en-US&page=1&region=us";
  }

  static String getUpComing() {
    return _upcoming + key + "&language=en-US&page=1";
  }

  static String getPeople(String id) {
    return _baseURL +
        "person/" +
        id +
        _apiField +
        key +
        "&language=en-US&append_to_response=images";
  }

  static String searchMovie(String query) {
    return _baseURL +
        "search/movie" +
        _apiField +
        key +
        "&language=en-US&page=1&include_adult=true&query=" +
        query;
  }

  static String popularCelebrities() {
    return _popularPeople + key + "&language=en-US&page=1";
  }
}
