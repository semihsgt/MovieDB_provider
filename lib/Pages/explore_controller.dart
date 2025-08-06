import 'package:flutter/material.dart';
import 'package:moviedb_org/Pages/details.dart';
import 'package:moviedb_org/ParseClasses/movies.dart';
import 'package:moviedb_org/gitignore/api_constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExplorePageController extends ChangeNotifier {
  List<MovParseResult>? movListParse;
  bool isLoading = false;

  ExplorePageController() {
    movParseFunc();
  }

  Future<void> movParseFunc() async {
    isLoading = true;
    notifyListeners();
    var url = Uri.parse(
      'https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc',
    );
    var response = await http.get(url, headers: ApiConstants.headers);
    final responseMap = json.decode(response.body);
    movListParse = MovParse.fromJson(responseMap).results;
    isLoading = false;
    notifyListeners();
  }

  void gridOnTap(BuildContext context, MovParseResult? mp) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailsPage(mp?.id)),
    );
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
