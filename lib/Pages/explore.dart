import 'package:flutter/material.dart';
import 'package:moviedb_org/pages/details.dart';
import 'package:moviedb_org/pages/explore_controller.dart';
import 'package:moviedb_org/reusable_widgets/movie_card.dart';
import 'package:provider/provider.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});
  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExplorePageController>(
      builder: (context, controller, child) {
        final movList = controller.movieList;

        if (controller.isLoading) {
          return Scaffold(
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
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (movList == null) {
          return const Center(
            child: Text(
              "Something went wrong.\nPlease try again later.",
              textAlign: TextAlign.center,
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFFE05A2B),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  '/Users/semihsogut/StudioProjects/Flutter/moviedb_provider/assets/images/app_icon_deleted_background.png',
                  height: 45,
                ),
                Text("MovieDB", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            itemCount: movList.length,
            itemBuilder: (context, index) {
              final mp = movList[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(movieId: mp.id),
                      ),
                    );
                  },
                  child: MovieCard(
                    mp: mp,
                    showOnlyDeleteButton: false,
                    pressedDeleteButton: () {},
                    pressedFavoriteButton: () {
                      controller.addOrRemoveFavorites(
                        mediaId: mp.id,
                        isFavorite: mp.isFavorite ? false : true,
                      );
                      controller.getFavoritesList();
                    },
                    pressedWatchlistButton: () {
                      controller.addOrRemoveWatchlist(
                        mediaId: mp.id,
                        isInWatchlist: mp.isInWatchlist ? false : true,
                      );
                      controller.getWatchlist();
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
