import 'package:flutter/material.dart';

import 'movie.dart';

class MoviePoster extends StatelessWidget {
  const MoviePoster({
    super.key,
    required this.movie,
    this.height = 180,
    this.width,
  });
  final Movie movie;
  final double height;
  final double? width;
  @override
  Widget build(BuildContext context) => Image.network(
    movie.posterUrl,
    height: height,
    width: width ?? double.infinity,
    fit: BoxFit.cover,
    // Ảnh lỗi/mất mạng không làm vỡ layout; vẫn thấy tên phim.
    errorBuilder: (_, error, stack) => Container(
      height: height,
      width: width ?? double.infinity,
      color: Theme.of(context).colorScheme.primaryContainer,
      padding: const EdgeInsets.all(8),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.movie_outlined, size: 36),
              const SizedBox(height: 8),
              Text(
                movie.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    loadingBuilder: (_, child, progress) => progress == null
        ? child
        : SizedBox(
            height: height,
            width: width ?? double.infinity,
            child: const Center(child: CircularProgressIndicator()),
          ),
  );
}
