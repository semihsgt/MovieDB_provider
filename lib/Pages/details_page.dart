import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:moviedb_org/parseClasses/popular_movies.dart';

class DetailsPage extends StatefulWidget {
  final PopMovResults? results;
  const DetailsPage(this.results, {super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE05A2B),
        title: Text("MovieDB", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Card(
              shadowColor: Colors.grey.shade800.withValues(colorSpace: ColorSpace.sRGB),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40))
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                    child: Image.network('https://image.tmdb.org/t/p/w1280${widget.results?.posterPath}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('\n${widget.results!.title!}\n', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center,),
                        Text("Describtion : \n\n${widget.results!.overview}"),
                        Text("\nRelease Date : ${widget.results!.releaseDate}"),
                        Text("\nVote Count : ${widget.results!.voteCount}"),
                        Text("\nOriginal Language : ${widget.results!.originalLanguage}\n"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}