import 'package:flutter/material.dart';
import 'package:moviedb_org/pages/library/library.dart';
import 'package:moviedb_org/pages/explore.dart';

class MyHomePageController extends ChangeNotifier {
  int selectedIndex = 0;
  List pageList = [ExplorePage(), LibraryPage()];

  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
