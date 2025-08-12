import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moviedb_org/models/movies_model.dart';
import 'package:moviedb_org/gitignore/api_constants.dart';

class DetailsPageController extends ChangeNotifier {
  Movie? movie;
  bool isLoading = false;

  DetailsPageController({required int movieId}) {
    movTopDetails(movieId);
  }


  Future<void> movTopDetails(int movieId) async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse(
      'https://api.themoviedb.org/3/movie/$movieId?language=en-US',
    );
    final response = await http.get(url, headers: ApiConstants.headers);
    final responseMap = json.decode(response.body);
    movie = Movie.fromJson(responseMap);
    isLoading = false;
    notifyListeners();
  }

  
}
