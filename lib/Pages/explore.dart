import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:moviedb_org/Pages/details_controller.dart';
import 'package:moviedb_org/Pages/explore_controller.dart';
import 'package:moviedb_org/ParseClasses/movies.dart';
import 'package:provider/provider.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});
  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExplorePageController(),
      child: Consumer<ExplorePageController>(
        builder: (context, controller, child) {
          final movList = controller.movListParse;

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

          return Scaffold(
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
            ),
            body: BodyDesign(movList: movList, controller: controller),
          );
        },
      ),
    );
  }
}

class BodyDesign extends StatelessWidget {
  const BodyDesign({
    super.key,
    required this.movList,
    required this.controller,
  });

  final ExplorePageController controller;
  final List<MovParseResult> movList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.52,
      ),
      itemCount: movList.length,
      itemBuilder: (context, index) {
        final mp = movList[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              controller.gridOnTap(context, mp);
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
                      'https://image.tmdb.org/t/p/w1280${mp.posterPath}',
                      loadingBuilder: (context, child, loadingProgress) {
                        return DetailsPageController.imageNetwork(
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
                      mp.title ?? "",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Spacer(),
                  Text('${mp.releaseDate}'),
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
