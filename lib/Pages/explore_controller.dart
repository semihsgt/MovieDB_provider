import 'package:flutter/material.dart';
import 'package:moviedb_org/models/movies_model.dart';
import 'package:moviedb_org/gitignore/api_constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExplorePageController extends ChangeNotifier {
  List<Movie>? movieList;
  List<Movie>? favoriteList;
  List<Movie>? watchlist;
  bool isLoading = false;

  ExplorePageController() {
    getMovies();
  }

  Future<void> getWatchlist() async {
    var url = Uri.parse(
      'https://api.themoviedb.org/3/account/22198136/watchlist/movies?language=en-US&page=1&sort_by=created_at.asc',
    );
    var response = await http.get(url, headers: ApiConstants.headers);
    final responseMap = json.decode(response.body);
    watchlist = MovieData.fromJson(responseMap).results;

    watchlist?.forEach((movie) {
      movie.isInWatchlist = true;
    });
    notifyListeners();
  }

  Future<void> getFavoritesList() async {
    var url = Uri.parse(
      'https://api.themoviedb.org/3/account/22198136/favorite/movies?language=en-US&page=1&sort_by=created_at.asc',
    );
    var response = await http.get(url, headers: ApiConstants.headers);
    final responseMap = json.decode(response.body);
    favoriteList = MovieData.fromJson(responseMap).results;

    favoriteList?.forEach((movie) {
      movie.isFavorite = true;
    });
    notifyListeners();
  }

  bool isContainsWatchlist(int id) {
    return watchlist?.any((movie) => movie.id == id) ?? false;
  }

  bool isContainsFavoritesList(int id) {
    return favoriteList?.any((movie) => movie.id == id) ?? false;
  }

  Future<void> getMovies() async {
    await getWatchlist();
    await getFavoritesList();
    isLoading = true;
    notifyListeners();
    var url = Uri.parse(
      'https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc',
    );
    var response = await http.get(url, headers: ApiConstants.headers);
    final responseMap = json.decode(response.body);
    movieList = MovieData.fromJson(responseMap).results;


    for (var i = 0; i < (movieList?.length ?? 0); i++) {
      final movie = movieList?[i];
      final isFav = isContainsFavoritesList(movie?.id ?? 0);
      final isInWatchlist = isContainsWatchlist(movie?.id ?? 0);
      movie?.isFavorite = isFav;
      movie?.isInWatchlist = isInWatchlist;
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> addOrRemoveFavorites({
    required int? mediaId,
    required bool isFavorite,
  }) async {
    final url = Uri.parse(
      'https://api.themoviedb.org/3/account/22198136/favorite',
    );
    final data = jsonEncode({
      "media_type": "movie",
      "media_id": mediaId,
      "favorite": isFavorite,
    });
    final response = await http.post(
      url,
      headers: ApiConstants.headers,
      body: data,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      print("TMDB response: ${responseData['status_message']}");

      final movie = movieList?.firstWhere((m) => m.id == mediaId);
      if (movie != null) {
        movie.isFavorite = isFavorite;
        notifyListeners();
      }
    } else {
      print("Error: ${response.statusCode} - ${response.body}");
    }
  }

  Future<void> addOrRemoveWatchlist({
    required int? mediaId,
    required bool isInWatchlist,
  }) async {
    final url = Uri.parse(
      'https://api.themoviedb.org/3/account/22198136/watchlist',
    );
    final data = jsonEncode({
      "media_type": "movie",
      "media_id": mediaId,
      "watchlist": isInWatchlist,
    });
    final response = await http.post(
      url,
      headers: ApiConstants.headers,
      body: data,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      print("TMDB response: ${responseData['status_message']}");

      final movie = movieList?.firstWhere((m) => m.id == mediaId);
      if (movie != null) {
        movie.isInWatchlist = isInWatchlist;
        notifyListeners();
      }
    } else {
      print("Error: ${response.statusCode} - ${response.body}");
    }
  }
}
