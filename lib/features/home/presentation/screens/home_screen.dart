import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider).valueOrNull;
    final firstName = user?.displayLabel.split(' ').first ?? 'Seeker';
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? 'Good Morning'
        : hour < 17
            ? 'Good Afternoon'
            : 'Good Evening';

    return Scaffold(
      backgroundColor: OjasColors.deepPurple,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _Header(greeting: greeting, firstName: firstName, user: user)),
            SliverToBoxAdapter(child: _DailyPracticeCard()),
            SliverToBoxAdapter(child: _SectionHeader(title: 'Quick Actions')),
            SliverToBoxAdapter(child: _QuickActions()),
            SliverToBoxAdapter(child: _SectionHeader(title: 'Upcoming Live Sessions', onSeeAll: () => context.go(Routes.live))),
            SliverToBoxAdapter(child: _UpcomingSessionsList()),
            SliverToBoxAdapter(child: _SectionHeader(title: 'Featured Courses', onSeeAll: () => context.go(Routes.learn))),
            SliverToBoxAdapter(child: _FeaturedCoursesList()),
            const SliverToBoxAdapter(child: SizedBox(height: OjasDimensions.xl)),
          ],
        ),
      ),
    );
  }
}

// ─── Header ──────────────────────────────────────────────────────────────────

class _Header extends ConsumerWidget {
  const _Header({required this.greeting, required this.firstName, required this.user});
  final String greeting;
  final String firstName;
  final dynamic user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        OjasDimensions.lg, OjasDimensions.md, OjasDimensions.lg, OjasDimensions.sm,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$greeting,',
                  style: OjasTextStyles.bodyMedium.copyWith(color: OjasColors.textSecondary),
                ),
                Text(
                  firstName,
                  style: OjasTextStyles.displayMedium,
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.auto_awesome, size: 12, color: OjasColors.gold),
                    const SizedBox(width: 4),
                    Text(
                      '"सर्वे भवन्तु सुखिनः" — May all be happy',
                      style: OjasTextStyles.bodySmall.copyWith(
                        color: OjasColors.gold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _AvatarButton(photoUrl: user?.photoUrl),
        ],
      ),
    );
  }
}

class _AvatarButton extends StatelessWidget {
  const _AvatarButton({this.photoUrl});
  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(Routes.profile),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: OjasColors.saffronGradient,
          boxShadow: [
            BoxShadow(
              color: OjasColors.saffron.withValues(alpha: 0.4),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ],
        ),
        child: photoUrl != null
            ? ClipOval(child: Image.network(photoUrl!, fit: BoxFit.cover))
            : const Icon(Icons.person, color: OjasColors.cream, size: 26),
      ),
    );
  }
}

// ─── Daily Practice Card ─────────────────────────────────────────────────────

class _DailyPracticeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: OjasDimensions.lg,
        vertical: OjasDimensions.md,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(OjasDimensions.radiusLg),
          gradient: const LinearGradient(
            colors: [Color(0xFF6B21A8), Color(0xFFFF6B00)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: OjasColors.saffron.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(OjasDimensions.lg),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: OjasColors.cream.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "TODAY'S PRACTICE",
                        style: OjasTextStyles.labelMedium.copyWith(
                          color: OjasColors.cream,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: OjasDimensions.sm),
                    const Text('Morning Pranayama\n& Meditation', style: OjasTextStyles.headlineLarge),
                    const SizedBox(height: OjasDimensions.xs),
                    Row(
                      children: [
                        const Icon(Icons.timer_outlined, size: 14, color: OjasColors.cream),
                        const SizedBox(width: 4),
                        Text('20 min', style: OjasTextStyles.bodySmall.copyWith(color: OjasColors.cream)),
                        const SizedBox(width: OjasDimensions.sm),
                        const Icon(Icons.signal_cellular_alt, size: 14, color: OjasColors.cream),
                        const SizedBox(width: 4),
                        Text('Beginner', style: OjasTextStyles.bodySmall.copyWith(color: OjasColors.cream)),
                      ],
                    ),
                    const SizedBox(height: OjasDimensions.md),
                    ElevatedButton.icon(
                      onPressed: () => context.go(Routes.learn),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: OjasColors.cream,
                        foregroundColor: OjasColors.deepPurple,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(OjasDimensions.radiusMd),
                        ),
                      ),
                      icon: const Icon(Icons.play_arrow, size: 18),
                      label: const Text('Begin', style: TextStyle(fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: OjasDimensions.md),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: OjasColors.cream.withValues(alpha: 0.15),
                ),
                child: const Icon(
                  Icons.self_improvement,
                  size: 48,
                  color: OjasColors.cream,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Quick Actions ───────────────────────────────────────────────────────────

class _QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const actions = [
      _QuickAction(icon: Icons.air, label: 'Meditate', route: Routes.learn, color: Color(0xFF7C3AED)),
      _QuickAction(icon: Icons.healing, label: 'Heal', route: Routes.heal, color: Color(0xFFDB2777)),
      _QuickAction(icon: Icons.play_circle_fill, label: 'Learn', route: Routes.learn, color: Color(0xFFEA580C)),
      _QuickAction(icon: Icons.live_tv, label: 'Go Live', route: Routes.live, color: Color(0xFF0EA5E9)),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: OjasDimensions.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: actions
            .map((a) => _QuickActionTile(action: a))
            .toList(),
      ),
    );
  }
}

class _QuickAction {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.route,
    required this.color,
  });
  final IconData icon;
  final String label;
  final String route;
  final Color color;
}

class _QuickActionTile extends StatelessWidget {
  const _QuickActionTile({required this.action});
  final _QuickAction action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(action.route),
      child: SizedBox(
        width: 72,
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: action.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(OjasDimensions.radiusMd),
                border: Border.all(color: action.color.withValues(alpha: 0.4)),
                boxShadow: [
                  BoxShadow(
                    color: action.color.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(action.icon, color: action.color, size: 28),
            ),
            const SizedBox(height: 6),
            Text(
              action.label,
              style: OjasTextStyles.labelMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Section Header ──────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.onSeeAll});
  final String title;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        OjasDimensions.lg, OjasDimensions.lg, OjasDimensions.lg, OjasDimensions.sm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: OjasTextStyles.headlineMedium),
          if (onSeeAll != null)
            GestureDetector(
              onTap: onSeeAll,
              child: Text(
                'See all',
                style: OjasTextStyles.labelMedium.copyWith(color: OjasColors.saffron),
              ),
            ),
        ],
      ),
    );
  }
}

// ─── Upcoming Sessions ───────────────────────────────────────────────────────

class _UpcomingSessionsList extends StatelessWidget {
  static final _sessions = [
    _SessionData(
      title: 'Kundalini Awakening',
      host: 'Ajay Swami',
      time: 'Today, 7:00 AM',
      tag: 'LIVE NOW',
      tagColor: OjasColors.error,
      icon: Icons.whatshot,
    ),
    _SessionData(
      title: 'Sound Healing Circle',
      host: 'Priya Devi',
      time: 'Today, 6:00 PM',
      tag: 'TONIGHT',
      tagColor: OjasColors.lotus,
      icon: Icons.music_note,
    ),
    _SessionData(
      title: 'Vedic Mantra Chanting',
      host: 'Ajay Swami',
      time: 'Tomorrow, 7:00 AM',
      tag: 'TOMORROW',
      tagColor: OjasColors.textMuted,
      icon: Icons.record_voice_over,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: OjasDimensions.lg),
        itemCount: _sessions.length,
        separatorBuilder: (_, __) => const SizedBox(width: OjasDimensions.sm),
        itemBuilder: (_, i) => _SessionCard(session: _sessions[i]),
      ),
    );
  }
}

class _SessionData {
  const _SessionData({
    required this.title,
    required this.host,
    required this.time,
    required this.tag,
    required this.tagColor,
    required this.icon,
  });
  final String title;
  final String host;
  final String time;
  final String tag;
  final Color tagColor;
  final IconData icon;
}

class _SessionCard extends StatelessWidget {
  const _SessionCard({required this.session});
  final _SessionData session;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(Routes.live),
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(OjasDimensions.md),
        decoration: BoxDecoration(
          color: OjasColors.surfacePurple,
          borderRadius: BorderRadius.circular(OjasDimensions.radiusMd),
          border: Border.all(color: OjasColors.cardPurple),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(session.icon, size: 16, color: session.tagColor),
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: session.tagColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    session.tag,
                    style: OjasTextStyles.labelMedium.copyWith(
                      color: session.tagColor,
                      fontSize: 10,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: OjasDimensions.xs),
            Text(session.title, style: OjasTextStyles.headlineMedium.copyWith(fontSize: 15), maxLines: 2, overflow: TextOverflow.ellipsis),
            const Spacer(),
            Text(session.host, style: OjasTextStyles.bodySmall.copyWith(color: OjasColors.saffron)),
            const SizedBox(height: 2),
            Row(
              children: [
                const Icon(Icons.access_time, size: 12, color: OjasColors.textMuted),
                const SizedBox(width: 4),
                Text(session.time, style: OjasTextStyles.bodySmall.copyWith(fontSize: 11)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Featured Courses ────────────────────────────────────────────────────────

class _FeaturedCoursesList extends StatelessWidget {
  static final _courses = [
    _CourseData(
      title: '21-Day Meditation\nChallenge',
      lessons: '21 lessons',
      duration: '8h 30min',
      level: 'All levels',
      gradientColors: [Color(0xFF1E1B4B), Color(0xFF7C3AED)],
      icon: Icons.self_improvement,
    ),
    _CourseData(
      title: 'Pranic Healing\nFoundations',
      lessons: '12 lessons',
      duration: '5h 15min',
      level: 'Beginner',
      gradientColors: [Color(0xFF1A0A2E), Color(0xFFDB2777)],
      icon: Icons.favorite,
    ),
    _CourseData(
      title: 'Yoga Nidra for\nDeep Sleep',
      lessons: '8 lessons',
      duration: '3h 45min',
      level: 'All levels',
      gradientColors: [Color(0xFF0C1445), Color(0xFF0EA5E9)],
      icon: Icons.nights_stay,
    ),
    _CourseData(
      title: 'Vedic Mantras\nMasterclass',
      lessons: '18 lessons',
      duration: '6h 20min',
      level: 'Intermediate',
      gradientColors: [Color(0xFF1A0A2E), Color(0xFFEA580C)],
      icon: Icons.record_voice_over,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: OjasDimensions.lg),
        itemCount: _courses.length,
        separatorBuilder: (_, __) => const SizedBox(width: OjasDimensions.sm),
        itemBuilder: (_, i) => _CourseCard(course: _courses[i]),
      ),
    );
  }
}

class _CourseData {
  const _CourseData({
    required this.title,
    required this.lessons,
    required this.duration,
    required this.level,
    required this.gradientColors,
    required this.icon,
  });
  final String title;
  final String lessons;
  final String duration;
  final String level;
  final List<Color> gradientColors;
  final IconData icon;
}

class _CourseCard extends StatelessWidget {
  const _CourseCard({required this.course});
  final _CourseData course;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(Routes.learn),
      child: Container(
        width: 165,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(OjasDimensions.radiusMd),
          gradient: LinearGradient(
            colors: course.gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: course.gradientColors.last.withValues(alpha: 0.35),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(OjasDimensions.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(OjasDimensions.radiusSm),
                ),
                child: Icon(course.icon, color: OjasColors.cream, size: 26),
              ),
              const Spacer(),
              Text(
                course.title,
                style: OjasTextStyles.headlineMedium.copyWith(fontSize: 14, height: 1.3),
                maxLines: 2,
              ),
              const SizedBox(height: OjasDimensions.xs),
              Text(
                course.lessons,
                style: OjasTextStyles.bodySmall.copyWith(color: OjasColors.textSecondary),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.timer_outlined, size: 11, color: OjasColors.textMuted),
                  const SizedBox(width: 3),
                  Text(course.duration, style: OjasTextStyles.bodySmall.copyWith(fontSize: 11)),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      course.level,
                      style: OjasTextStyles.bodySmall.copyWith(
                        fontSize: 11,
                        color: OjasColors.saffron,
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
}
