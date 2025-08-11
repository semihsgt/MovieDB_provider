import 'package:flutter/material.dart';
import 'package:moviedb_org/pages/library/favorites.dart';
import 'package:moviedb_org/pages/library/library_controller.dart';
import 'package:moviedb_org/pages/library/watchlist.dart';
import 'package:provider/provider.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
      final a = Provider.of<LibraryPageController>(context, listen: false);
      a.initController(this);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LibraryPageController>(
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
                    '/Users/semihsogut/StudioProjects/Flutter/moviedb_provider/assets/images/app_icon_deleted_background.png',
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
    );
  }
}
