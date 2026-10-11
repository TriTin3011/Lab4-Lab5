import 'package:flutter/material.dart';

import 'calculator_app.dart';
import 'lab4/core_widgets_demo.dart';
import 'lab4/debug_fixes_demo.dart';
import 'lab4/input_controls_demo.dart';
import 'lab4/layout_demo.dart';
import 'lab4/scaffold_demo.dart';
import 'movies/movie_home_screen.dart';
import 'random_number_app.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.darkMode,
    required this.onThemeChanged,
  });

  final bool darkMode;
  final ValueChanged<bool> onThemeChanged;

  void _open(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute<void>(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    final lab4Items = <_NavItem>[
      const _NavItem(
        'Core Widgets',
        'Text · Image · Card',
        Icons.widgets_rounded,
        CoreWidgetsDemo(),
      ),
      const _NavItem(
        'Input Controls',
        'Slider · Switch · Picker',
        Icons.tune_rounded,
        InputControlsDemo(),
      ),
      const _NavItem(
        'Layout Basics',
        'Row · Column · ListView',
        Icons.dashboard_rounded,
        LayoutDemo(),
      ),
      _NavItem(
        'Scaffold & Theme',
        'AppBar · FAB · Theme',
        Icons.palette_rounded,
        ScaffoldDemo(onThemeChanged: onThemeChanged),
      ),
      const _NavItem(
        'Debug & Fix',
        'Overflow · State · Context',
        Icons.bug_report_rounded,
        DebugFixesDemo(),
      ),
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: const Row(
              children: [
                _Logo(),
                SizedBox(width: 12),
                Text(
                  'Flutter Studio',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ],
            ),
            actions: [
              IconButton(
                tooltip: darkMode
                    ? 'Chuyển sang chế độ sáng'
                    : 'Chuyển sang chế độ tối',
                onPressed: () => onThemeChanged(!darkMode),
                icon: Icon(
                  darkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
            sliver: SliverList.list(
              children: [
                Text(
                  'Học Flutter qua\nnhững trải nghiệm thật.',
                  style: Theme.of(context).textTheme.headlineMedium
                      ?.copyWith(fontWeight: FontWeight.w900, height: 1.12),
                ),
                const SizedBox(height: 10),
                Text(
                  'Hai bài lab, tám trải nghiệm, một ứng dụng duy nhất.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 28),
                _MovieFeatureCard(
                  onTap: () => _open(context, const MovieHomeScreen()),
                ),
                const SizedBox(height: 32),
                const _SectionTitle(
                  title: 'Lab 4 · UI Fundamentals',
                  count: '05 bài',
                ),
                const SizedBox(height: 14),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 158,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: lab4Items.length,
                  itemBuilder: (context, index) {
                    final item = lab4Items[index];
                    return _LabCard(
                      index: index + 1,
                      item: item,
                      onTap: () => _open(context, item.screen),
                    );
                  },
                ),
                const SizedBox(height: 32),
                const _SectionTitle(title: 'Tiện ích', count: '02 công cụ'),
                const SizedBox(height: 14),
                _ToolCard(
                  icon: Icons.calculate_rounded,
                  color: const Color(0xFF7C5CFC),
                  title: 'Calculator',
                  subtitle: 'Cộng, trừ, nhân và chia',
                  onTap: () => _open(context, const CalculatorApp()),
                ),
                const SizedBox(height: 12),
                _ToolCard(
                  icon: Icons.casino_rounded,
                  color: const Color(0xFFFF8A5B),
                  title: 'Random Number',
                  subtitle: 'Sinh số trong khoảng Min – Max',
                  onTap: () => _open(context, const RandomNumberApp()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();
  @override
  Widget build(BuildContext context) => Container(
    width: 38,
    height: 38,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF8B6CFF), Color(0xFF5A3EE8)],
      ),
      borderRadius: BorderRadius.circular(13),
    ),
    child: const Icon(
      Icons.auto_awesome_rounded,
      color: Colors.white,
      size: 20,
    ),
  );
}

class _MovieFeatureCard extends StatelessWidget {
  const _MovieFeatureCard({required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: BorderRadius.circular(28),
      onTap: onTap,
      child: Ink(
        height: 250,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF5B3FD8), Color(0xFF24194F), Color(0xFF111522)],
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x553D23A7),
              blurRadius: 34,
              offset: Offset(0, 16),
            ),
          ],
        ),
        child: Stack(
          children: [
            const Positioned(
              right: -8,
              top: -10,
              child: Icon(
                Icons.movie_filter_rounded,
                size: 150,
                color: Color(0x1FFFFFFF),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _Pill(
                  icon: Icons.local_fire_department_rounded,
                  text: 'LAB 5 · FEATURED',
                ),
                const Spacer(),
                const Text(
                  'Movie Premiere',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Khám phá những bộ phim đang chiếu nổi bật',
                  style: TextStyle(color: Colors.white70, fontSize: 15),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF32227A),
                      ),
                      onPressed: onTap,
                      icon: const Icon(Icons.play_arrow_rounded),
                      label: const Text('Khám phá'),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

class _Pill extends StatelessWidget {
  const _Pill({required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white12,
      borderRadius: BorderRadius.circular(30),
      border: Border.all(color: Colors.white24),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: const Color(0xFFFFC46B), size: 16),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.8,
          ),
        ),
      ],
    ),
  );
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.count});
  final String title;
  final String count;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.w800),
        ),
      ),
      Text(
        count,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );
}

class _LabCard extends StatelessWidget {
  const _LabCard({
    required this.index,
    required this.item,
    required this.onTap,
  });
  final int index;
  final _NavItem item;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Card(
    child: InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    item.icon,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const Spacer(),
                Text(
                  index.toString().padLeft(2, '0'),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              item.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
            ),
            const SizedBox(height: 4),
            Text(
              item.subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _ToolCard extends StatelessWidget {
  const _ToolCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: color.withValues(alpha: .15),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
    ),
  );
}

class _NavItem {
  const _NavItem(this.title, this.subtitle, this.icon, this.screen);
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget screen;
}
