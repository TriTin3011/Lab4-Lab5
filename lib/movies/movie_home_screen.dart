import 'package:flutter/material.dart';

import 'movie.dart';
import 'sample_data.dart';
import 'movie_poster.dart';
import 'movie_detail_screen.dart';

class MovieHomeScreen extends StatefulWidget {
  const MovieHomeScreen({super.key});
  @override
  State<MovieHomeScreen> createState() => _MovieHomeScreenState();
}

class _MovieHomeScreenState extends State<MovieHomeScreen> {
  String _query = '';
  String _genre = 'Tất cả';
  final Map<String, MovieSelection> _selections = {};

  void _open(Movie movie) {
    // Truyền Movie vào constructor; callback giữ lựa chọn khi quay lại.
    Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
        builder: (_) => MovieDetailScreen(
          movie: movie,
          selection:
              _selections[movie.id] ?? const MovieSelection(favorite: false),
          onSelectionChanged: (value) {
            if (mounted) setState(() => _selections[movie.id] = value);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final movies = sampleMovies
        .where(
          (movie) =>
              movie.title.toLowerCase().contains(_query.toLowerCase()) &&
              (_genre == 'Tất cả' || movie.genres.contains(_genre)),
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Now Showing',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Phim đang chiếu',
                  style: Theme.of(context).textTheme.headlineMedium
                      ?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 6),
                Text(
                  'Cập nhật ngày 11/10/2026',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search_rounded),
                    hintText: 'Tìm tên phim...',
                    suffixIcon: Icon(Icons.tune_rounded),
                  ),
                  onChanged: (value) => setState(() => _query = value.trim()),
                ),
                const SizedBox(height: 14),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final genre in [
                        'Tất cả',
                        'Drama',
                        'Animation',
                        'Horror',
                      ])
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(genre),
                            selected: _genre == genre,
                            onSelected: (_) => setState(() => _genre = genre),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: movies.isEmpty
                ? const Center(child: Text('Không tìm thấy phim.'))
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
                    itemCount: movies.length,
                    itemBuilder: (context, i) {
                      final movie = movies[i];
                      final state = _selections[movie.id];
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        margin: const EdgeInsets.only(bottom: 14),
                        child: InkWell(
                          onTap: () => _open(movie),
                          child: Row(
                            children: [
                              Hero(
                                tag: 'poster-${movie.id}',
                                child: MoviePoster(
                                  movie: movie,
                                  width: 108,
                                  height: 164,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movie.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w900,
                                            ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        movie.genres.take(2).join(' · '),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 5,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF3DDC97)
                                                  .withValues(alpha: .13),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: const Text(
                                              'ĐANG CHIẾU',
                                              style: TextStyle(
                                                color: Color(0xFF3DDC97),
                                                fontSize: 9,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            movie.releaseLabel,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Icon(
                                            movie.rating > 0 ? Icons.star_rounded : Icons.star_outline_rounded,
                                            size: 17,
                                            color: movie.rating > 0
                                                ? const Color(0xFFFFC857)
                                                : Theme.of(context).colorScheme.onSurfaceVariant,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            movie.rating > 0 ? '${movie.rating} / 10' : 'Chưa có điểm',
                                            style: TextStyle(
                                              color: movie.rating > 0
                                                  ? const Color(0xFFFFC857)
                                                  : Theme.of(context).colorScheme.onSurfaceVariant,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (state?.personalRating != null)
                                        Text(
                                          'Bạn: ${state!.personalRating} / 10',
                                        ),
                                      if (state?.favorite ?? false)
                                        const Padding(
                                          padding: EdgeInsets.only(top: 8),
                                          child: Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Icon(Icons.chevron_right),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
