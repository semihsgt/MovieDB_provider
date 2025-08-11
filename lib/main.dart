import 'package:flutter/material.dart';
import 'package:moviedb_org/main_controller.dart';
import 'package:moviedb_org/pages/explore_controller.dart';
import 'package:moviedb_org/pages/library/library_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ExplorePageController>(
          create: (context) => ExplorePageController(),
        ),
        ChangeNotifierProvider<MyHomePageController>(
          create: (context) => MyHomePageController(),
        ),
        ChangeNotifierProvider<LibraryPageController>(
          create: (context) => LibraryPageController(),
        ),
      ],
      builder: (context, child) {
        return const MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MovieDB',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyHomePageController>(
      builder: (context, controller, child) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Color(0xFFE05A2B),
            currentIndex: controller.selectedIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_add_check),
                label: 'Library',
              ),
            ],
            onTap: (index) {
              controller.changeIndex(index);
              if (index == 1) {
                final getFavorites = Provider.of<LibraryPageController>(
                  context,
                  listen: false,
                );
                getFavorites.getFavoritesList();
              }
            },
          ),
          body: controller.pageList[controller.selectedIndex],
        );
      },
    );
  }
}
