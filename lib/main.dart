import 'package:flutter/material.dart';
import 'package:moviedb_org/main_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MovieDB',
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
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
    return ChangeNotifierProvider(
      create: (context) => MyHomePageController(),
      child: Consumer<MyHomePageController>(
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
              },
            ),
            body: controller.pageList[controller.selectedIndex],
          );
        },
      ),
    );
  }
}


// 2.⁠ ⁠favorite/watchlist buttonlar
// 3.⁠ ⁠imagesdan resimleri cekip slider