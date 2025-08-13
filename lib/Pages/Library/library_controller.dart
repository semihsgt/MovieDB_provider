import 'package:flutter/material.dart';
import 'package:moviedb_org/models/movies_model.dart';
import 'package:moviedb_org/gitignore/api_constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LibraryPageController extends ChangeNotifier {
  late TabController tabController;
  List<Movie>? movieList;
  List<Movie>? favoriteList;
  List<Movie>? watchlist;
  bool isFavoritesLoading = false;
  bool isWatchlistLoading = false;
  bool isLoading = false;

  LibraryPageController() {
    getMovies();
  }

  void initController(TickerProvider vsync) {
    tabController = TabController(length: 2, vsync: vsync);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Future<void> getFavoritesList() async {
    isFavoritesLoading = true;
    notifyListeners();
    var url = Uri.parse(
      'https://api.themoviedb.org/3/account/22198136/favorite/movies?language=en-US&page=1&sort_by=created_at.asc',
    );
    var response = await http.get(url, headers: ApiConstants.headers);
    final responseMap = json.decode(response.body);
    favoriteList = MovieData.fromJson(responseMap).results;

    favoriteList?.forEach((movie) {
      movie.isFavorite = true;
    });

    isFavoritesLoading = false;
    notifyListeners();
  }

  Future<void> getWatchlist() async {
    isWatchlistLoading = true;
    notifyListeners();
    var url = Uri.parse(
      'https://api.themoviedb.org/3/account/22198136/watchlist/movies?language=en-US&page=1&sort_by=created_at.asc',
    );
    var response = await http.get(url, headers: ApiConstants.headers);
    final responseMap = json.decode(response.body);
    watchlist = MovieData.fromJson(responseMap).results;

    watchlist?.forEach((movie) {
      movie.isInWatchlist = true;
    });

    isWatchlistLoading = false;
    notifyListeners();
  }

  Future<void> getMovies() async {
    await getFavoritesList();
    await getWatchlist();
    var url = Uri.parse(
      'https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc',
    );
    var response = await http.get(url, headers: ApiConstants.headers);
    final responseMap = json.decode(response.body);
    movieList = MovieData.fromJson(responseMap).results;
  }

  Future<void> removeFavorites({
    required int? mediaId,
  }) async {
    final url = Uri.parse(
      'https://api.themoviedb.org/3/account/22198136/favorite',
    );
    final data = jsonEncode({
      "media_type": "movie",
      "media_id": mediaId,
      "favorite": false,
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
        movie.isFavorite = false;
        getFavoritesList();
      }
    } else {
      print("Error: ${response.statusCode} - ${response.body}");
    }
  }

  Future<void> removeWatchlist({
    required int? mediaId,
  }) async {
    final url = Uri.parse(
      'https://api.themoviedb.org/3/account/22198136/watchlist',
    );
    final data = jsonEncode({
      "media_type": "movie",
      "media_id": mediaId,
      "watchlist": false,
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
        movie.isInWatchlist = false;
        getWatchlist();
      }
    } else {
      print("Error: ${response.statusCode} - ${response.body}");
    }
  }
}
