import 'package:flutter/material.dart';
import 'package:moviedb_org/core/network/network_manager.dart';
import 'package:moviedb_org/models/movies_model.dart';

class ExplorePageController extends ChangeNotifier {
  List<Movie>? movieList;
  List<Movie>? favoriteList;
  List<Movie>? watchlist;
  bool isLoading = false;

  ExplorePageController() {
    getMovies();
  }

  Future<void> getWatchlist() async {
    final response = await NetworkManager.instance.getRequest<MovieData>(
      '/3/account/22198136/watchlist/movies',
      queryParam: {'language': 'en=US', 'page': 1, 'sort_by': 'created_at.asc'},
      model: MovieData(),
    );

    watchlist = response?.results;

    watchlist?.forEach((movie) {
      movie.isInWatchlist = true;
    });
    notifyListeners();
  }

  Future<void> getFavoritesList() async {
    final response = await NetworkManager.instance.getRequest(
      '/3/account/22198136/favorite/movies',
      queryParam: {'language': 'en=US', 'page': 1, 'sort_by': 'created_at.asc'},
      model: MovieData(),
    );

    favoriteList = response?.results;

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

  Future<void> getMovies({bool hideLoading = false}) async {
    await getWatchlist();
    await getFavoritesList();
    if (hideLoading == false) {
      isLoading = true;
      notifyListeners();
    }

    final response = await NetworkManager.instance.getRequest(
      '/3/discover/movie',
      queryParam: {
        'include_adult': 'false',
        'include_video': 'false',
        'language': 'en-US',
        'page': 1,
        'sort_by': 'popularity.desc',
      },
      model: MovieData(),
    );
    movieList = response?.results;

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
    final data = {
      "media_type": "movie",
      "media_id": mediaId,
      "favorite": isFavorite,
    };

    await NetworkManager.instance.postRequest(
      '/3/account/22198136/favorite',
      body: data,
    );

    final movie = movieList?.firstWhere((m) => m.id == mediaId);
    if (movie != null) {
      movie.isFavorite = isFavorite;
      notifyListeners();
    }

    // if (response.statusCode == 200 || response.statusCode == 201) {
    //   final responseData = jsonDecode(response.body);
    //   print("TMDB response: ${responseData['status_message']}");
    // } else {
    //   print("Error: ${response.statusCode} - ${response.body}");
    // }
  }

  Future<void> addOrRemoveWatchlist({
    required int? mediaId,
    required bool isInWatchlist,
  }) async {
    final data = {
      "media_type": "movie",
      "media_id": mediaId,
      "watchlist": isInWatchlist,
    };

    await NetworkManager.instance.postRequest(
      '/3/account/22198136/watchlist',
      body: data,
    );

    final movie = movieList?.firstWhere((m) => m.id == mediaId);
    if (movie != null) {
      movie.isInWatchlist = isInWatchlist;
      notifyListeners();
    }

    // if (response.statusCode == 200 || response.statusCode == 201) {
    //   final responseData = jsonDecode(response.body);
    //   print("TMDB response: ${responseData['status_message']}");

    // } else {
    //   print("Error: ${response.statusCode} - ${response.body}");
    // }
  }
}
