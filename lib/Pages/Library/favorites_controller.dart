import 'package:flutter/material.dart';
import 'package:moviedb_org/ParseClasses/movies.dart';
import 'package:http/http.dart' as http;
import 'package:moviedb_org/gitignore/api_constants.dart';
import 'dart:convert';

class FavoritesPageController extends ChangeNotifier {
  List<MovParseResult>? movie;
  bool isLoading = false;

  FavoritesPageController() {
    _movFavParse();
  }

  Future<void> _movFavParse() async {
    isLoading = true;
    notifyListeners();
    var url = Uri.parse(
      'https://api.themoviedb.org/3/account/22198136/favorite/movies?language=en-US&page=1&sort_by=created_at.asc',
    );
    var response = await http.get(url, headers: ApiConstants.headers);
    final responseMap = json.decode(response.body);
    movie = MovParse.fromJson(responseMap).results;
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
