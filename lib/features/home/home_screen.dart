import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:razor_mind/core/constants/app_colors.dart';
import 'package:razor_mind/core/utils/level_utils.dart';
import 'package:razor_mind/core/utils/rank_utils.dart';
import 'package:razor_mind/data/models/category_model.dart';
import 'package:razor_mind/data/providers/progress_provider.dart';
import 'package:razor_mind/data/providers/question_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Buenos días ☀️';
    if (hour < 19) return 'Buenas tardes 🌤️';
    return 'Buenas noches 🌙';
  }

  String _formattedDate() {
    const months = [
      'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
      'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre',
    ];
    const days = [
      'lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado', 'domingo',
    ];
    final now = DateTime.now();
    final dayName = days[now.weekday - 1];
    final monthName = months[now.month - 1];
    return '$dayName, ${now.day} de $monthName';
  }

  bool _isCompletedToday(UserProgress progress) {
    final now = DateTime.now();
    final today = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    return progress.activityDates.contains(today);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(progressProvider);
    final level = LevelUtils.getLevel(progress.totalXp);
    final levelProgress = LevelUtils.getLevelProgress(progress.totalXp);
    final levelTitle = LevelUtils.getLevelTitle(level);
    final xpForNext = LevelUtils.getXpForNextLevel(level);
    final xpForCurrent = LevelUtils.getXpForLevel(level);
    final xpToNext = xpForNext - progress.totalXp;

    final completedToday = _isCompletedToday(progress);
    final accuracyPct = (progress.correctRate * 100).round();
    final accuracyColor = progress.correctRate >= 0.7
        ? AppColors.correct
        : progress.correctRate >= 0.5
            ? AppColors.secondary
            : AppColors.error;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ─── Header ────────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _greeting(),
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _formattedDate(),
                                style: const TextStyle(
                                  color: AppColors.textTertiary,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // XP Chip
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('⚡', style: TextStyle(fontSize: 14)),
                              const SizedBox(width: 4),
                              Text(
                                '${progress.totalXp} XP',
                                style: const TextStyle(
                                  color: AppColors.primaryLight,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ).animate().fadeIn(duration: 400.ms),
                  ],
                ),
              ),
            ),
          ),

          // ─── Level + Rank Card ──────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF1E1E40), Color(0xFF12122A)],
                  ),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: AppColors.border),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.15),
                      blurRadius: 28,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Avatar circle with level
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppColors.primaryLight, AppColors.primaryDark],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.4),
                                blurRadius: 14,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              '$level',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        // Level info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nivel $level · $levelTitle',
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${progress.totalXp} XP · $xpToNext para siguiente',
                                style: const TextStyle(
                                  color: AppColors.textTertiary,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Rank badge
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            context.push('/ranking');
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: RankUtils.getRankColor(progress.rankPoints).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: RankUtils.getRankColor(progress.rankPoints).withOpacity(0.4),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  RankUtils.getRankEmoji(progress.rankPoints),
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  RankUtils.getRankName(progress.rankPoints),
                                  style: TextStyle(
                                    color: RankUtils.getRankColor(progress.rankPoints),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // XP progress bar
                    LinearPercentIndicator(
                      percent: levelProgress.clamp(0.0, 1.0),
                      lineHeight: 8,
                      backgroundColor: AppColors.border,
                      progressColor: AppColors.primary,
                      barRadius: const Radius.circular(4),
                      padding: EdgeInsets.zero,
                      animation: true,
                      animationDuration: 800,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${progress.totalXp - xpForCurrent} XP en nivel $level',
                          style: const TextStyle(color: AppColors.textTertiary, fontSize: 11),
                        ),
                        Text(
                          '$xpToNext XP para nivel ${level + 1}',
                          style: const TextStyle(color: AppColors.textTertiary, fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ).animate(delay: 80.ms).fadeIn(duration: 500.ms).slideY(begin: 0.08, duration: 500.ms),
            ),
          ),

          // ─── Daily Challenge Card ───────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: completedToday
                  ? _CompletedTodayCard()
                  : _DailyChallengeCard(streak: progress.currentStreak),
            ),
          ),

          // ─── Quick Stats Row ────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: _QuickStatCard(
                      icon: '🔥',
                      value: '${progress.currentStreak}',
                      label: 'Racha',
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _QuickStatCard(
                      icon: '🎯',
                      value: '$accuracyPct%',
                      label: 'Precisión',
                      color: accuracyColor,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _QuickStatCard(
                      icon: '⭐',
                      value: '${progress.bestStreak}',
                      label: 'Mejor racha',
                      color: AppColors.primaryLight,
                    ),
                  ),
                ],
              ).animate(delay: 240.ms).fadeIn(duration: 400.ms),
            ),
          ),

          // ─── Game Modes ─────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text(
                      'Modos de juego',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      children: _gameModes.asMap().entries.map((e) {
                        final mode = e.value;
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: _GameModeCard(
                            mode: mode,
                            index: e.key,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ).animate(delay: 300.ms).fadeIn(duration: 400.ms),
            ),
          ),

          // ─── Explore Categories ─────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text(
                      'Categorías',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      children: AppCategories.all.asMap().entries.map((e) {
                        final cat = e.value;
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: _CategoryChip(
                            category: cat,
                            index: e.key,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ).animate(delay: 380.ms).fadeIn(duration: 400.ms),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Daily Challenge Card
// ─────────────────────────────────────────────────────────────────────────────

class _DailyChallengeCard extends StatelessWidget {
  const _DailyChallengeCard({required this.streak});

  final int streak;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        context.push('/challenge?mode=daily');
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primary, AppColors.primaryDark],
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.35),
              blurRadius: 28,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'DESAFÍO DIARIO',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        '🎯 ',
                        style: TextStyle(fontSize: 18),
                      ),
                      const Text(
                        '10 preguntas · General',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        '¡Mantén tu racha! ',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        '$streak',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                      ),
                      const Text(
                        '🔥',
                        style: TextStyle(fontSize: 14),
                      )
                          .animate(onPlay: (c) => c.repeat(reverse: true))
                          .scaleXY(begin: 0.85, end: 1.15, duration: 900.ms),
                      Text(
                        ' días',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: const Text(
                      'Comenzar ahora →',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text('🎯', style: TextStyle(fontSize: 28)),
              ),
            ),
          ],
        ),
      ).animate(delay: 160.ms).fadeIn(duration: 500.ms).slideY(begin: 0.08, duration: 500.ms),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Completed Today Card
// ─────────────────────────────────────────────────────────────────────────────

class _CompletedTodayCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.correct.withOpacity(0.08),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.correct.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.correct.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.check_circle_rounded, color: AppColors.correct, size: 28),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Completado hoy',
                  style: TextStyle(
                    color: AppColors.correct,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '¡Vuelve mañana para continuar tu racha!',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate(delay: 160.ms).fadeIn(duration: 500.ms);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Quick Stat Card
// ─────────────────────────────────────────────────────────────────────────────

class _QuickStatCard extends StatelessWidget {
  const _QuickStatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  final String icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textTertiary,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Game Mode Data
// ─────────────────────────────────────────────────────────────────────────────

class _GameModeData {
  final String emoji;
  final String name;
  final String description;
  final List<Color> gradientColors;
  final String route;

  const _GameModeData({
    required this.emoji,
    required this.name,
    required this.description,
    required this.gradientColors,
    required this.route,
  });
}

const _gameModes = [
  _GameModeData(
    emoji: '🎯',
    name: 'Diario',
    description: '10 preguntas',
    gradientColors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
    route: '/challenge?mode=daily',
  ),
  _GameModeData(
    emoji: '⚡',
    name: 'Velocidad',
    description: 'Contrarreloj',
    gradientColors: [Color(0xFFF59E0B), Color(0xFFD97706)],
    route: '/challenge?mode=speed',
  ),
  _GameModeData(
    emoji: '🏃',
    name: 'Maratón',
    description: '30 preguntas',
    gradientColors: [Color(0xFF10B981), Color(0xFF059669)],
    route: '/learn', // Navigate to learn to choose a category first
  ),
  _GameModeData(
    emoji: '❤️',
    name: 'Supervivencia',
    description: '3 vidas',
    gradientColors: [Color(0xFFEF4444), Color(0xFFB91C1C)],
    route: '/challenge?mode=survival',
  ),
];

// ─────────────────────────────────────────────────────────────────────────────
// Game Mode Card
// ─────────────────────────────────────────────────────────────────────────────

class _GameModeCard extends StatelessWidget {
  const _GameModeCard({required this.mode, required this.index});

  final _GameModeData mode;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        context.push(mode.route);
      },
      child: Container(
        width: 160,
        height: 90,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: mode.gradientColors,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: mode.gradientColors.first.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(mode.emoji, style: const TextStyle(fontSize: 18)),
                const Spacer(),
                const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 14),
              ],
            ),
            const Spacer(),
            Text(
              mode.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            Text(
              mode.description,
              style: TextStyle(
                color: Colors.white.withOpacity(0.75),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ).animate(delay: Duration(milliseconds: 60 * index)).fadeIn(duration: 300.ms).slideX(begin: 0.1, duration: 300.ms),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Category Chip (horizontal scroll)
// ─────────────────────────────────────────────────────────────────────────────

class _CategoryChip extends ConsumerWidget {
  const _CategoryChip({required this.category, required this.index});

  final CategoryModel category;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.watch(questionsByCategoryProvider(category.id));

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        context.push('/learn/${category.id}');
      },
      child: Container(
        width: 80,
        height: 90,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: category.color.withOpacity(0.4),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: category.color.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(category.emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 5),
            Text(
              category.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 10,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              '${questions.length} preguntas',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textTertiary,
                fontSize: 9,
              ),
            ),
          ],
        ),
      ).animate(delay: Duration(milliseconds: 50 * index)).fadeIn(duration: 300.ms).slideX(begin: 0.1, duration: 300.ms),
    );
  }
}
