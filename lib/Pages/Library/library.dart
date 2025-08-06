import 'package:flutter/material.dart';
import 'package:moviedb_org/Pages/Library/favorites.dart';
import 'package:moviedb_org/Pages/Library/library_controller.dart';
import 'package:moviedb_org/Pages/Library/watchlist.dart';
import 'package:provider/provider.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage>
    with SingleTickerProviderStateMixin {
  late LibraryPageController controller;

  @override
  void initState() {
    super.initState();
    controller = LibraryPageController();
    controller.initController(this);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LibraryPageController>.value(
      value: controller,
      child: Consumer<LibraryPageController>(
        builder: (context, controller, child) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xFFE05A2B),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      '/Users/semihsogut/StudioProjects/Flutter/moviedb/assets/images/app_icon_deleted_background.png',
                      height: 45,
                    ),
                    Text(
                      "MovieDB",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                bottom: TabBar(
                  controller: controller.tabController,
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  indicatorWeight: 5,
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.favorite),
                          SizedBox(width: 5),
                          Text('Favorites'),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.watch_later),
                          SizedBox(width: 5),
                          Text('Watchlist'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                controller: controller.tabController,
                children: [FavoritesPage(), WatchlistPage()],
              ),
            ),
          );
        },
      ),
    );
  }
}
