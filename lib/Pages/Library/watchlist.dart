import 'package:flutter/material.dart';
import 'package:moviedb_org/pages/library/library_controller.dart';
import 'package:moviedb_org/pages/details.dart';
import 'package:moviedb_org/reusable_widgets/movie_card.dart';
import 'package:provider/provider.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LibraryPageController>(
      builder: (context, controller, child) {
        final movList = controller.watchlist;

        if (controller.isWatchlistLoading) {
          return Scaffold(
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

        if (movList.isEmpty) {
          return const Center(
            child: Text(
              "You don't have any movies\non your watchlist!",
              textAlign: TextAlign.center,
            ),
          );
        }

        return GridView.builder(
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
                  showOnlyDeleteButton: true,
                  pressedFavoriteButton: () {},
                  pressedWatchlistButton: () {},
                  pressedDeleteButton: () {
                    controller.removeWatchlist(mediaId: mp.id);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
