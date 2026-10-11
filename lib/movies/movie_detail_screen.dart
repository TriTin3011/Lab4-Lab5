import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'movie.dart';
import 'movie_poster.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({
    super.key,
    required this.movie,
    required this.selection,
    required this.onSelectionChanged,
  });
  final Movie movie;
  final MovieSelection selection;
  final ValueChanged<MovieSelection> onSelectionChanged;
  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late bool _favorite = widget.selection.favorite;
  late int? _rating = widget.selection.personalRating;

  void _update() => widget.onSelectionChanged(
    MovieSelection(favorite: _favorite, personalRating: _rating),
  );

  Future<void> _rate() async {
    double value = (_rating ?? 8).toDouble();
    final result = await showDialog<int>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, updateDialog) => AlertDialog(
          title: const Text('Đánh giá phim'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${value.round()} / 10'),
              Slider(
                value: value,
                min: 1,
                max: 10,
                divisions: 9,
                label: '${value.round()}',
                onChanged: (v) => updateDialog(() => value = v),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Hủy'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, value.round()),
              child: const Text('Lưu'),
            ),
          ],
        ),
      ),
    );
    if (!mounted || result == null) return;
    setState(() => _rating = result);
    _update();
  }

  Future<void> _share() async {
    final score = widget.movie.rating > 0
        ? '★ ${widget.movie.rating}/10'
        : 'Đang chiếu';
    await Clipboard.setData(
      ClipboardData(
        text: '${widget.movie.title} — $score\n${widget.movie.overview}',
      ),
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã sao chép thông tin phim để chia sẻ.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: IconButton.filledTonal(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_rounded),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: IconButton.filledTonal(
              onPressed: _share,
              icon: const Icon(Icons.ios_share_rounded),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Hero(
            tag: 'poster-${movie.id}',
            child: Stack(
              children: [
                Image.network(
                  movie.backdropUrl,
                  height: 440,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) =>
                      MoviePoster(movie: movie, height: 440),
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: .08),
                          Colors.black.withValues(alpha: .96),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 22,
                  right: 22,
                  bottom: 26,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF35D49A),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text(
                          'ĐANG CHIẾU',
                          style: TextStyle(
                            color: Color(0xFF062A20),
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: .7,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        movie.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 31,
                          height: 1.1,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movie.tagline,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _InfoItem(
                        icon: Icons.calendar_month_rounded,
                        label: 'Khởi chiếu',
                        value: movie.releaseLabel,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _InfoItem(
                        icon: Icons.star_rounded,
                        label: 'Đánh giá',
                        value: movie.rating > 0
                            ? '${movie.rating}/10'
                            : 'Chưa có',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    for (final genre in movie.genres) Chip(label: Text(genre)),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  movie.studio,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (_rating != null) Text('Đánh giá của bạn: $_rating / 10'),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          setState(() => _favorite = !_favorite);
                          _update();
                        },
                        icon: Icon(
                          _favorite ? Icons.favorite : Icons.favorite_border,
                        ),
                        label: Text(_favorite ? 'Đã lưu' : 'Yêu thích'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: _rate,
                        icon: const Icon(Icons.star_outline_rounded),
                        label: const Text('Đánh giá'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Text(
                  'Nội dung phim',
                  style: Theme.of(context).textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 10),
                Text(movie.overview, style: const TextStyle(height: 1.6)),
                const SizedBox(height: 28),
                Text(
                  'Trailer & Video',
                  style: Theme.of(context).textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: movie.trailers.length,
                  itemBuilder: (context, i) {
                    final trailer = movie.trailers[i];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          leading: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              Icons.play_arrow_rounded,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          title: Text(trailer.title),
                          subtitle: Text(
                            '${trailer.type} · ${trailer.duration}',
                          ),
                          trailing: const Icon(Icons.chevron_right_rounded),
                          onTap: () => showDialog<void>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(trailer.title),
                              content: Text(
                                '${movie.title} · ${trailer.duration}\nDanh sách trailer minh họa bằng dữ liệu tĩnh theo yêu cầu lab; chưa tích hợp phát video.',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Đóng'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Row(
      children: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
