import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:moviedb_org/Pages/details_controller.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final int? movieId;
  const DetailsPage(this.movieId, {super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DetailsPageController(movieId: widget.movieId ?? 0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFE05A2B),
          title: Text("MovieDB", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: BodyDesign(),
      ),
    );
  }
}

final class BodyDesign extends StatelessWidget {
  const BodyDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Consumer<DetailsPageController>(
            builder: (context, controller, child) {
              final movie = controller.movie;

              if (controller.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (movie == null) {
                return const Center(
                  child: Text(
                    "Something went wrong.\nPlease try again later.",
                    textAlign: TextAlign.center,
                  ),
                );
              }

              return Card(
                shadowColor: Colors.grey.shade800.withValues(
                  colorSpace: ColorSpace.sRGB,
                ),
                elevation: 10,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w1280/${movie.posterPath}',
                        loadingBuilder: (context, child, loadingProgress) {
                          return DetailsPageController.imageNetwork(
                            context,
                            child,
                            loadingProgress,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\n${movie.title ?? ""}\n',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text("Describtion : \n\n${movie.overview}"),
                          Text("\nRelease Date : ${movie.releaseDate}"),
                          Text("\nVote Count : ${movie.voteCount}"),
                          Text(
                            "\nOriginal Language : ${movie.originalLanguage}",
                          ),
                          Text("\nBudget : ${movie.budget}\n"),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
