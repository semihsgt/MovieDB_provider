import 'package:flutter/material.dart';

class LibraryPageController extends ChangeNotifier {
  late TabController tabController;

  void initController(TickerProvider vsync) {
    tabController = TabController(length: 2, vsync: vsync);
    notifyListeners();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
