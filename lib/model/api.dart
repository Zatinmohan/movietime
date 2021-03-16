import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movietime/model/castModel.dart';
import 'package:movietime/model/movieModel.dart';
import 'package:movietime/model/movieallDetails.dart';
import 'package:movietime/model/url.dart';

class APIManager {
  var _movieModel;

  check(var response) {
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      _movieModel = MovieModel.fromJson(jsonString);
    }
  }

  check_movie(var response) {
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      _movieModel = MovieDetailModel.fromJson(jsonString);
    }
  }

  checkPerson(var response) {
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      _movieModel = CastModel.fromJson(jsonString);
    }
  }

  Future<MovieModel> getTrendingMovies() async {
    try {
      var response = await http.get(URLs.getTrendingURL());
      check(response);
    } catch (Exception) {
      return null;
    }

    return _movieModel;
  }

  Future<MovieModel> getPopularMovies() async {
    try {
      var response = await http.get(URLs.getPopularURL());
      check(response);
    } catch (Exception) {
      return null;
    }
    return _movieModel;
  }

  Future<MovieModel> getNowPlaying() async {
    try {
      var response = await http.get(URLs.getNowPlayingURL());
      check(response);
    } catch (Exception) {
      return null;
    }
    return _movieModel;
  }

  Future<MovieModel> getupComing() async {
    try {
      var response = await http.get(URLs.getUpComing());
      check(response);
    } catch (Exception) {
      return null;
    }
    return _movieModel;
  }

  Future<MovieDetailModel> getDetails(String id) async {
    try {
      var response = await http.get(URLs.getMoviesURL(id));
      check_movie(response);
    } catch (Exception) {
      return null;
    }
    return _movieModel;
  }

  Future<MovieModel> getRecommendation(String id) async {
    try {
      var response = await http.get(URLs.getRecommendation(id));
      check(response);
    } catch (Exception) {
      return null;
    }
    return _movieModel;
  }

  Future<CastModel> getPeople(String id) async {
    try {
      var response = await http.get(URLs.getPeople(id));
      checkPerson(response);
    } catch (Exception) {
      return null;
    }
    return _movieModel;
  }

  Future<MovieModel> searchMovies(String query) async {
    try {
      var response = await http.get(URLs.searchMovie(query));
      check(response);
    } catch (Exception) {
      return null;
    }
    return _movieModel;
  }

  Future<CastModel> popularPeople() async {
    try {
      var response = await http.get(URLs.popularCelebrities());
      checkPerson(response);
    } catch (Exception) {
      return null;
    }
    return _movieModel;
  }
}
