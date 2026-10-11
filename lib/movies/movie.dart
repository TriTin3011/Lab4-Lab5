// Model bất biến được truyền trực tiếp giữa hai route.
class Trailer {
  const Trailer({
    required this.title,
    required this.duration,
    required this.type,
  });
  final String title;
  final String duration;
  final String type;
}

class Movie {
  const Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.backdropUrl,
    required this.overview,
    required this.tagline,
    required this.genres,
    required this.studio,
    required this.releaseDate,
    required this.rating,
    required this.trailers,
  });
  final String id;
  final String title;
  final String posterUrl;
  final String backdropUrl;
  final String overview;
  final String tagline;
  final List<String> genres;
  final String studio;
  final DateTime releaseDate;
  final double rating;
  final List<Trailer> trailers;

  String get releaseLabel {
    final day = releaseDate.day.toString().padLeft(2, '0');
    final month = releaseDate.month.toString().padLeft(2, '0');
    return '$day/$month/${releaseDate.year}';
  }
}

class MovieSelection {
  const MovieSelection({required this.favorite, this.personalRating});
  final bool favorite;
  final int? personalRating;
}
