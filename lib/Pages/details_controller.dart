import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moviedb_org/ParseClasses/movies_top_details.dart';
import 'package:moviedb_org/gitignore/api_constants.dart';

class DetailsPageController extends ChangeNotifier {
  MovTopDetailsParse? movie;
  bool isLoading = false;

  DetailsPageController({required int movieId}) {
    movTopDetailsParse(movieId);
  }

  Future<void> movTopDetailsParse(int movieId) async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse(
      'https://api.themoviedb.org/3/movie/$movieId?language=en-US',
    );
    final response = await http.get(url, headers: ApiConstants.headers);
    final responseMap = json.decode(response.body);
    movie = MovTopDetailsParse.fromJson(responseMap);
    isLoading = false;
    notifyListeners();
  }

  static Widget imageNetwork(
    BuildContext context,
    Widget child,
    ImageChunkEvent? loadingProgress,
  ) {
    if (loadingProgress == null) {
      return child;
    } else {
      return Center(
        child: CircularProgressIndicator(
          value:
              loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes!)
                  : null,
        ),
      );
    }
  }
}
