import 'package:flutter/material.dart';
import 'package:moviedb_org/core/network/network_manager.dart';
import 'package:moviedb_org/models/movies_model.dart';

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

  Future<void> getFavoritesList({bool hideLoading = false}) async {
    if (hideLoading == false) {
      isFavoritesLoading = true;
      notifyListeners();
    }

    var response = await NetworkManager.instance.getRequest(
      '/3/account/22198136/favorite/movies',
      queryParam: {'language': 'en-US', 'page': 1, 'sort_by': 'created_at.asc'},
      model: MovieData(),
    );

    favoriteList = response?.results;

    favoriteList?.forEach((movie) {
      movie.isFavorite = true;
    });

    isFavoritesLoading = false;
    notifyListeners();
  }

  Future<void> getWatchlist({bool hideLoading = false}) async {
    if (hideLoading == false) {
      isFavoritesLoading = true;
      notifyListeners();
    }

    var response = await NetworkManager.instance.getRequest(
      '/3/account/22198136/watchlist/movies',
      queryParam: {'language': 'en-US', 'page': 1, 'sort_by': 'created_at.asc'},
      model: MovieData(),
    );
    watchlist = response?.results;

    watchlist?.forEach((movie) {
      movie.isInWatchlist = true;
    });

    isWatchlistLoading = false;
    notifyListeners();
  }

  Future<void> getMovies() async {
    await getFavoritesList();
    await getWatchlist();

    var response = await NetworkManager.instance.getRequest(
      '/3/discover/movie?',
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
  }

  Future<void> removeFavorites({required int? mediaId}) async {
    final data = {
      "media_type": "movie",
      "media_id": mediaId,
      "favorite": false,
    };

    await NetworkManager.instance.postRequest(
      '/3/account/22198136/favorite',
      body: data,
    );

    final movie = movieList?.firstWhere((m) => m.id == mediaId);
    if (movie != null) {
      movie.isFavorite = false;
      await getFavoritesList(hideLoading: true);
    }

    // if (response.statusCode == 200 || response.statusCode == 201) {
    //   final responseData = jsonDecode(response.body);
    //   print("TMDB response: ${responseData['status_message']}");
    // } else {
    //   print("Error: ${response.statusCode} - ${response.body}");
    // }
  }

  Future<void> removeWatchlist({required int? mediaId}) async {
    final data = {
      "media_type": "movie",
      "media_id": mediaId,
      "watchlist": false,
    };

    await NetworkManager.instance.postRequest(
      '/3/account/22198136/watchlist',
      body: data,
    );

    final movie = movieList?.firstWhere((m) => m.id == mediaId);
    if (movie != null) {
      movie.isInWatchlist = false;
      await getWatchlist(hideLoading: true);
    }

    // if (response.statusCode == 200 || response.statusCode == 201) {
    //   final responseData = jsonDecode(response.body);
    //   print("TMDB response: ${responseData['status_message']}");
    // } else {
    //   print("Error: ${response.statusCode} - ${response.body}");
    // }
  }
}
