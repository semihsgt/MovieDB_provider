import 'package:flutter/material.dart';
import 'package:moviedb_org/core/network/network_manager.dart';
import 'package:moviedb_org/models/movies_model.dart';

class DetailsPageController extends ChangeNotifier {
  Movie? movie;
  bool isLoading = false;

  DetailsPageController({required int movieId}) {
    movTopDetails(movieId);
  }

  Future<void> movTopDetails(int movieId) async {
    isLoading = true;
    notifyListeners();
    var response = await NetworkManager.instance.getRequest(
      '/3/movie/$movieId',
      queryParam: {'language': 'en-US'},
      model: Movie(),
    );
    movie = response;
    isLoading = false;
    notifyListeners();
  }
}
