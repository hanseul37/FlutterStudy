import 'dart:convert';
import 'package:movie/models/movie_detail_model.dart';
import 'package:movie/models/movie_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://movies-api.nomadcoders.workers.dev';
  static const String popular = 'popular';
  static const String now = 'now-playing';
  static const String soon = 'coming-soon';

  static Future<List<MovieModel>> popularMovies() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse('$baseUrl/$popular');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseJson = jsonDecode(response.body);
      final List<dynamic> moviesPop = responseJson['results'];
      for (var moviePop in moviesPop) {
        movieInstances.add(MovieModel.fromJson(moviePop));
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<List<MovieModel>> nowMovies() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse('$baseUrl/$now');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseJson = jsonDecode(response.body);
      final List<dynamic> moviesNow = responseJson['results'];
      for (var movieNow in moviesNow) {
        movieInstances.add(MovieModel.fromJson(movieNow));
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<List<MovieModel>> soonMovies() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse('$baseUrl/$soon');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseJson = jsonDecode(response.body);
      final List<dynamic> moviesSoon = responseJson['results'];
      for (var movieSoon in moviesSoon) {
        movieInstances.add(MovieModel.fromJson(movieSoon));
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<MovieDetailModel> getMovieById(int id) async {
    final url = Uri.parse('$baseUrl/movie?id=$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final movie = jsonDecode(response.body);
      return MovieDetailModel.fromJson(movie);
    }
    throw Error();
  }
}
