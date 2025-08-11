import 'package:flutter/material.dart';
import 'package:moviedb_org/pages/library/library_controller.dart';
import 'package:moviedb_org/pages/library/library.dart';
import 'package:moviedb_org/pages/explore.dart';
import 'package:provider/provider.dart';

class MyHomePageController extends ChangeNotifier {
  int selectedIndex = 0;
  List pageList = [
    ExplorePage(),
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LibraryPageController>(
          create: (context) => LibraryPageController(),
        ),
      ],
      builder: (context, child) {
        return LibraryPage();
      },
    ),
  ];

  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
