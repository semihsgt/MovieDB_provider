import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({super.key, required this.posterPath});
  final String posterPath;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://image.tmdb.org/t/p/w1280$posterPath',
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {

        if (loadingProgress == null) {
          return child;
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
