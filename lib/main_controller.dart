import 'package:flutter/material.dart';
import 'package:moviedb_org/Pages/Library/library.dart';
import 'package:moviedb_org/Pages/explore.dart';

class MyHomePageController extends ChangeNotifier {
  int selectedIndex = 0;
  final pageList = [ExplorePage(), LibraryPage()];

  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
