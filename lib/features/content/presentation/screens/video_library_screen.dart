import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';

// ─── Mock data ────────────────────────────────────────────────────────────────

enum _Category { all, meditation, healing, yoga, mantras, breathwork }

extension _CategoryLabel on _Category {
  String get label => switch (this) {
        _Category.all => 'All',
        _Category.meditation => 'Meditation',
        _Category.healing => 'Healing',
        _Category.yoga => 'Yoga',
        _Category.mantras => 'Mantras',
        _Category.breathwork => 'Breathwork',
      };
}

class _Course {
  const _Course({
    required this.id,
    required this.title,
    required this.instructor,
    required this.duration,
    required this.lessons,
    required this.level,
    required this.category,
    required this.gradientColors,
    required this.icon,
    this.isPremium = false,
    required this.rating,
    required this.students,
  });

  final String id;
  final String title;
  final String instructor;
  final String duration;
  final int lessons;
  final String level;
  final _Category category;
  final List<Color> gradientColors;
  final IconData icon;
  final bool isPremium;
  final double rating;
  final int students;
}

const _allCourses = [
  _Course(
    id: 'c1',
    title: '21-Day Meditation Challenge',
    instructor: 'Ajay Swami',
    duration: '8h 30min',
    lessons: 21,
    level: 'All levels',
    category: _Category.meditation,
    gradientColors: [Color(0xFF1E1B4B), Color(0xFF7C3AED)],
    icon: Icons.self_improvement,
    rating: 4.9,
    students: 3240,
  ),
  _Course(
    id: 'c2',
    title: 'Pranic Healing Foundations',
    instructor: 'Priya Devi',
    duration: '5h 15min',
    lessons: 12,
    level: 'Beginner',
    category: _Category.healing,
    gradientColors: [Color(0xFF4A0020), Color(0xFFDB2777)],
    icon: Icons.favorite,
    isPremium: true,
    rating: 4.8,
    students: 1870,
  ),
  _Course(
    id: 'c3',
    title: 'Yoga Nidra for Deep Sleep',
    instructor: 'Ajay Swami',
    duration: '3h 45min',
    lessons: 8,
    level: 'All levels',
    category: _Category.yoga,
    gradientColors: [Color(0xFF0C1445), Color(0xFF0EA5E9)],
    icon: Icons.nights_stay,
    rating: 4.7,
    students: 2560,
  ),
  _Course(
    id: 'c4',
    title: 'Vedic Mantra Masterclass',
    instructor: 'Ajay Swami',
    duration: '6h 20min',
    lessons: 18,
    level: 'Intermediate',
    category: _Category.mantras,
    gradientColors: [Color(0xFF1A0A2E), Color(0xFFEA580C)],
    icon: Icons.record_voice_over,
    isPremium: true,
    rating: 4.9,
    students: 980,
  ),
  _Course(
    id: 'c5',
    title: 'Pranayama Breathwork Series',
    instructor: 'Priya Devi',
    duration: '4h 10min',
    lessons: 10,
    level: 'Beginner',
    category: _Category.breathwork,
    gradientColors: [Color(0xFF003322), Color(0xFF059669)],
    icon: Icons.air,
    rating: 4.6,
    students: 1420,
  ),
  _Course(
    id: 'c6',
    title: 'Chakra Balancing Yoga',
    instructor: 'Ajay Swami',
    duration: '5h 50min',
    lessons: 14,
    level: 'Intermediate',
    category: _Category.yoga,
    gradientColors: [Color(0xFF1A0A2E), Color(0xFFD97706)],
    icon: Icons.blur_circular,
    isPremium: true,
    rating: 4.8,
    students: 1105,
  ),
  _Course(
    id: 'c7',
    title: 'Mindfulness Meditation',
    instructor: 'Priya Devi',
    duration: '2h 30min',
    lessons: 6,
    level: 'Beginner',
    category: _Category.meditation,
    gradientColors: [Color(0xFF1E1B4B), Color(0xFF6D28D9)],
    icon: Icons.spa,
    rating: 4.7,
    students: 4100,
  ),
  _Course(
    id: 'c8',
    title: 'Advanced Healing Techniques',
    instructor: 'Priya Devi',
    duration: '7h 00min',
    lessons: 16,
    level: 'Advanced',
    category: _Category.healing,
    gradientColors: [Color(0xFF3B0764), Color(0xFFEC4899)],
    icon: Icons.healing,
    isPremium: true,
    rating: 4.9,
    students: 620,
  ),
];

// ─── State ────────────────────────────────────────────────────────────────────

final _selectedCategoryProvider =
    StateProvider<_Category>((_) => _Category.all);

final _searchQueryProvider = StateProvider<String>((_) => '');

final _filteredCoursesProvider = Provider<List<_Course>>((ref) {
  final cat = ref.watch(_selectedCategoryProvider);
  final query = ref.watch(_searchQueryProvider).toLowerCase().trim();

  return _allCourses.where((c) {
    final matchesCat = cat == _Category.all || c.category == cat;
    final matchesQuery = query.isEmpty ||
        c.title.toLowerCase().contains(query) ||
        c.instructor.toLowerCase().contains(query);
    return matchesCat && matchesQuery;
  }).toList();
});

// ─── Screen ───────────────────────────────────────────────────────────────────

class VideoLibraryScreen extends ConsumerWidget {
  const VideoLibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: OjasColors.deepPurple,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _SearchBar(),
            _CategoryChips(),
            const SizedBox(height: OjasDimensions.sm),
            const Expanded(child: _CourseGrid()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        OjasDimensions.lg, OjasDimensions.md, OjasDimensions.lg, OjasDimensions.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Learn & Grow', style: OjasTextStyles.displayMedium),
          const SizedBox(height: 2),
          Text(
            '${_allCourses.length} courses • Meditation, Healing & Yoga',
            style: OjasTextStyles.bodySmall.copyWith(color: OjasColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

// ─── Search bar ───────────────────────────────────────────────────────────────

class _SearchBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: OjasDimensions.lg,
        vertical: OjasDimensions.sm,
      ),
      child: TextField(
        onChanged: (v) => ref.read(_searchQueryProvider.notifier).state = v,
        style: OjasTextStyles.bodyMedium,
        decoration: InputDecoration(
          hintText: 'Search courses, instructors…',
          hintStyle: OjasTextStyles.bodyMedium.copyWith(color: OjasColors.textMuted),
          prefixIcon: const Icon(Icons.search, color: OjasColors.textMuted, size: 20),
          filled: true,
          fillColor: OjasColors.surfacePurple,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(OjasDimensions.radiusMd),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

// ─── Category chips ───────────────────────────────────────────────────────────

class _CategoryChips extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(_selectedCategoryProvider);

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: OjasDimensions.lg),
        itemCount: _Category.values.length,
        separatorBuilder: (_, __) => const SizedBox(width: OjasDimensions.sm),
        itemBuilder: (_, i) {
          final cat = _Category.values[i];
          final isSelected = cat == selected;
          return GestureDetector(
            onTap: () =>
                ref.read(_selectedCategoryProvider.notifier).state = cat,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? OjasColors.saffron : OjasColors.surfacePurple,
                borderRadius: BorderRadius.circular(OjasDimensions.radiusFull),
                border: Border.all(
                  color: isSelected ? OjasColors.saffron : OjasColors.cardPurple,
                ),
              ),
              child: Text(
                cat.label,
                style: OjasTextStyles.labelMedium.copyWith(
                  color: isSelected ? OjasColors.cream : OjasColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ─── Course grid ──────────────────────────────────────────────────────────────

class _CourseGrid extends ConsumerWidget {
  const _CourseGrid();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courses = ref.watch(_filteredCoursesProvider);

    if (courses.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search_off, size: 48, color: OjasColors.textMuted),
            const SizedBox(height: OjasDimensions.sm),
            Text('No courses found', style: OjasTextStyles.bodyMedium.copyWith(color: OjasColors.textMuted)),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: OjasDimensions.lg,
        vertical: OjasDimensions.sm,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: OjasDimensions.sm,
        mainAxisSpacing: OjasDimensions.sm,
        childAspectRatio: 0.78,
      ),
      itemCount: courses.length,
      itemBuilder: (_, i) => _CourseCard(course: courses[i]),
    );
  }
}

// ─── Course card ──────────────────────────────────────────────────────────────

class _CourseCard extends StatelessWidget {
  const _CourseCard({required this.course});
  final _Course course;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showCourseSheet(context, course),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(OjasDimensions.radiusMd),
          gradient: LinearGradient(
            colors: course.gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: course.gradientColors.last.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(OjasDimensions.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(OjasDimensions.radiusSm),
                    ),
                    child: Icon(course.icon, color: OjasColors.cream, size: 22),
                  ),
                  if (course.isPremium)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: OjasColors.gold.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(OjasDimensions.radiusFull),
                        border: Border.all(color: OjasColors.gold.withValues(alpha: 0.5)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.workspace_premium, size: 10, color: OjasColors.gold),
                          const SizedBox(width: 3),
                          Text(
                            'PRO',
                            style: OjasTextStyles.labelMedium.copyWith(
                              fontSize: 9,
                              color: OjasColors.gold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const Spacer(),
              Text(
                course.title,
                style: OjasTextStyles.headlineMedium.copyWith(fontSize: 13, height: 1.3),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                course.instructor,
                style: OjasTextStyles.bodySmall.copyWith(color: OjasColors.saffron, fontSize: 11),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.play_lesson_outlined, size: 11, color: OjasColors.textMuted),
                  const SizedBox(width: 3),
                  Text(
                    '${course.lessons} lessons',
                    style: OjasTextStyles.bodySmall.copyWith(fontSize: 11),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  const Icon(Icons.star, size: 11, color: OjasColors.gold),
                  const SizedBox(width: 3),
                  Text(
                    course.rating.toStringAsFixed(1),
                    style: OjasTextStyles.bodySmall.copyWith(fontSize: 11),
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      _formatStudents(course.students),
                      style: OjasTextStyles.bodySmall.copyWith(
                        fontSize: 11,
                        color: OjasColors.textMuted,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatStudents(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k students';
    return '$n students';
  }
}

// ─── Course detail bottom sheet ───────────────────────────────────────────────

void _showCourseSheet(BuildContext context, _Course course) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _CourseDetailSheet(course: course),
  );
}

class _CourseDetailSheet extends StatelessWidget {
  const _CourseDetailSheet({required this.course});
  final _Course course;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.92,
      builder: (_, scrollController) => Container(
        decoration: const BoxDecoration(
          color: OjasColors.surfacePurple,
          borderRadius: BorderRadius.vertical(top: Radius.circular(OjasDimensions.radiusXl)),
        ),
        child: Column(
          children: [
            const SizedBox(height: OjasDimensions.sm),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: OjasColors.textMuted,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.all(OjasDimensions.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero banner
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(OjasDimensions.radiusMd),
                        gradient: LinearGradient(
                          colors: course.gradientColors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Icon(course.icon, size: 56, color: OjasColors.cream),
                      ),
                    ),
                    const SizedBox(height: OjasDimensions.md),

                    // Title + premium badge
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(course.title, style: OjasTextStyles.headlineLarge),
                        ),
                        if (course.isPremium) ...[
                          const SizedBox(width: OjasDimensions.sm),
                          const Icon(Icons.workspace_premium, color: OjasColors.gold, size: 24),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'by ${course.instructor}',
                      style: OjasTextStyles.bodyMedium.copyWith(color: OjasColors.saffron),
                    ),
                    const SizedBox(height: OjasDimensions.md),

                    // Stats row
                    Row(
                      children: [
                        _Stat(icon: Icons.timer_outlined, label: course.duration),
                        const SizedBox(width: OjasDimensions.lg),
                        _Stat(icon: Icons.play_lesson_outlined, label: '${course.lessons} lessons'),
                        const SizedBox(width: OjasDimensions.lg),
                        _Stat(icon: Icons.signal_cellular_alt, label: course.level),
                      ],
                    ),
                    const SizedBox(height: OjasDimensions.sm),
                    Row(
                      children: [
                        _Stat(icon: Icons.star, label: '${course.rating}  rating', iconColor: OjasColors.gold),
                        const SizedBox(width: OjasDimensions.lg),
                        _Stat(icon: Icons.people_outline, label: '${_fmt(course.students)} enrolled'),
                      ],
                    ),
                    const SizedBox(height: OjasDimensions.lg),

                    // Divider
                    const Divider(color: OjasColors.cardPurple),
                    const SizedBox(height: OjasDimensions.md),

                    // What you'll learn
                    Text("What you'll learn", style: OjasTextStyles.headlineMedium),
                    const SizedBox(height: OjasDimensions.sm),
                    ..._bulletPoints(course.category).map(
                      (p) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.check_circle, size: 16, color: OjasColors.saffron),
                            const SizedBox(width: OjasDimensions.sm),
                            Expanded(child: Text(p, style: OjasTextStyles.bodyMedium)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: OjasDimensions.xl),

                    // CTA
                    SizedBox(
                      width: double.infinity,
                      height: OjasDimensions.buttonHeight,
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          course.isPremium ? Icons.lock_open : Icons.play_arrow,
                        ),
                        label: Text(
                          course.isPremium ? 'Unlock with Premium' : 'Start Course — Free',
                          style: OjasTextStyles.labelLarge,
                        ),
                      ),
                    ),
                    const SizedBox(height: OjasDimensions.md),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _fmt(int n) => n >= 1000 ? '${(n / 1000).toStringAsFixed(1)}k' : '$n';

  List<String> _bulletPoints(_Category cat) => switch (cat) {
        _Category.meditation => [
            'Build a consistent daily meditation practice',
            'Learn breath-awareness and body-scan techniques',
            'Reduce stress, anxiety and mental chatter',
            'Access deeper states of inner stillness',
          ],
        _Category.healing => [
            'Understand pranic and energy healing principles',
            'Learn scanning and cleansing techniques',
            'Heal emotional and physical imbalances',
            'Develop sensitivity to subtle energy fields',
          ],
        _Category.yoga => [
            'Master foundational yoga asanas safely',
            'Improve flexibility, strength, and balance',
            'Integrate breath with movement (vinyasa)',
            'Experience deeper mind-body connection',
          ],
        _Category.mantras => [
            'Pronounce Vedic mantras with correct intonation',
            'Understand the meaning and vibration of each mantra',
            'Use mantra for manifestation and healing',
            'Build a personal mantra sadhana (practice)',
          ],
        _Category.breathwork => [
            'Master pranayama techniques (Nadi Shodhana, Kapalbhati)',
            'Balance the nervous system through breath',
            'Increase lung capacity and vital energy (prana)',
            'Use breathwork for emotional regulation',
          ],
        _Category.all => [
            'Access a wide variety of spiritual practices',
            'Learn from experienced teachers and healers',
            'Develop a holistic wellness routine',
            'Connect with a community of seekers',
          ],
      };
}

class _Stat extends StatelessWidget {
  const _Stat({required this.icon, required this.label, this.iconColor});
  final IconData icon;
  final String label;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: iconColor ?? OjasColors.textMuted),
        const SizedBox(width: 4),
        Text(label, style: OjasTextStyles.bodySmall),
      ],
    );
  }
}
