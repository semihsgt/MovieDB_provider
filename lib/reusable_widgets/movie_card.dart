import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:moviedb_org/models/movies_model.dart';
import 'package:moviedb_org/reusable_widgets/custom_image.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.mp,
    required this.pressedFavoriteButton,
    required this.pressedWatchlistButton,
  });

  final Movie mp;
  final Function pressedFavoriteButton;
  final Function pressedWatchlistButton;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Card(
            elevation: 10,
            shadowColor: Colors.grey.shade800.withValues(
              colorSpace: ColorSpace.sRGB,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CustomImage(posterPath: mp.posterPath ?? ''),
          ),
        ),

        IconButton(
          color: Colors.white,
          onPressed: () {
            pressedFavoriteButton();
          },
          icon: Icon(
            mp.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: mp.isFavorite ? Color(0xFFE05A2B) : Colors.white,
          ),
        ),

        Positioned(
          right: 0,
          child: IconButton(
            color: Colors.white,
            onPressed: () {
              pressedWatchlistButton();
            },
            icon: Icon(
              mp.isInWatchlist ? Icons.watch_later : Icons.watch_later_outlined,
              color: mp.isInWatchlist ? Color(0xFFE05A2B) : Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}