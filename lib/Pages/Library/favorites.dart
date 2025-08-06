import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:moviedb_org/Pages/Library/favorites_controller.dart';
import 'package:moviedb_org/Pages/details.dart';
import 'package:moviedb_org/ParseClasses/movies.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoritesPageController(),
      child: Consumer<FavoritesPageController>(
        builder: (context, controller, child) {
          final movList = controller.movie;

          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
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
                "You don't have any movies\non your favorites list!",
                textAlign: TextAlign.center,
              ),
            );
          }

          return BodyDesign(movList: movList);
        },
      ),
    );
  }
}

class BodyDesign extends StatelessWidget {
  const BodyDesign({super.key, required this.movList});

  final List<MovParseResult>? movList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.52,
      ),
      itemCount: movList?.length,
      itemBuilder: (context, index) {
        final mp = movList?[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailsPage(mp?.id)),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              shadowColor: Colors.grey.shade800.withValues(
                colorSpace: ColorSpace.sRGB,
              ),
              elevation: 10,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w1280${mp?.posterPath}',
                      loadingBuilder: (context, child, loadingProgress) {
                        return FavoritesPageController.imageNetwork(
                          context,
                          child,
                          loadingProgress,
                        );
                      },
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                      mp?.title ?? "",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Spacer(),
                  Text('${mp?.releaseDate}'),
                  Spacer(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
