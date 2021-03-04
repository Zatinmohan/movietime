import 'package:shared_preferences/shared_preferences.dart';

class SharedFiles {
  static SharedPreferences _preferences;
  final String key_name = "MovieList";

  //Use the factory keyword when implementing a constructor that doesn’t always create a new instance of its class.
  //For example, a factory constructor might return an instance from a cache, or it might return an instance of a subtype
  //Another use case for factory constructors is initializing a final variable using logic that can’t be handled in the initializer list.

  factory SharedFiles() => SharedFiles._internal();
  SharedFiles._internal();

  start() async {
    if (_preferences == null)
      _preferences = await SharedPreferences.getInstance();
  }

  checkMovie() {
    return _preferences.containsKey(key_name) ? true : false;
  }

  setMovies(List<String> movieList) {
    _preferences.setStringList(key_name, movieList);
  }

  getMovies() {
    List<String> movieList = _preferences.getStringList(key_name);
    return movieList;
  }
}
