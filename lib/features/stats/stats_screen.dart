import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razor_mind/core/constants/app_colors.dart';
import 'package:razor_mind/core/utils/level_utils.dart';
import 'package:razor_mind/data/models/category_model.dart';
import 'package:razor_mind/data/providers/progress_provider.dart';
import 'package:razor_mind/features/stats/widgets/stat_card.dart';
import 'package:razor_mind/features/stats/widgets/streak_calendar.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(progressProvider);

    final level = LevelUtils.getLevel(progress.totalXp);
    final levelTitle = LevelUtils.getLevelTitle(level);
    final levelProgress = LevelUtils.getLevelProgress(progress.totalXp);
    final xpForCurrent = LevelUtils.xpForCurrentLevel(progress.totalXp);
    final xpForNext = LevelUtils.xpForNextLevel(progress.totalXp);
    final accuracyPct = (progress.correctRate * 100).round();

    final accuracyColor = progress.correctRate >= 0.7
        ? AppColors.correct
        : progress.correctRate >= 0.5
            ? AppColors.secondary
            : AppColors.error;

    final achievements = [
      _Achievement(
        emoji: '🎯',
        label: 'Primer Paso',
        desc: 'Responde tu primera pregunta',
        unlocked: progress.totalQuestionsAnswered >= 1,
      ),
      _Achievement(
        emoji: '🔥',
        label: 'En Racha',
        desc: 'Alcanza 7 días seguidos',
        unlocked: progress.currentStreak >= 7,
      ),
      _Achievement(
        emoji: '📚',
        label: 'Erudito',
        desc: 'Responde 100 preguntas',
        unlocked: progress.totalQuestionsAnswered >= 100,
      ),
      _Achievement(
        emoji: '⭐',
        label: 'Perfecto',
        desc: 'Logra >90% de precisión',
        unlocked: progress.correctRate >= 0.9 && progress.totalQuestionsAnswered >= 10,
      ),
      _Achievement(
        emoji: '🌍',
        label: 'Explorador',
        desc: 'Responde 30 preguntas',
        unlocked: progress.totalQuestionsAnswered >= 30,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Estadísticas',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w800,
                      fontSize: 28,
                    ),
                  ).animate().fadeIn(duration: 400.ms),
                  const SizedBox(height: 4),
                  const Text(
                    'Tu progreso de aprendizaje',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                  ).animate(delay: 80.ms).fadeIn(duration: 400.ms),
                ],
              ),
            ),
          ),

          // Overall stats row
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: StatCard(
                      label: 'XP Total',
                      value: '${progress.totalXp}',
                      icon: '⚡',
                      color: AppColors.primary,
                      animationDelay: 0,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: StatCard(
                      label: 'Racha actual',
                      value: '${progress.currentStreak}',
                      icon: '🔥',
                      color: AppColors.secondary,
                      subtitle: 'días',
                      animationDelay: 80,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: StatCard(
                      label: 'Precisión',
                      value: '$accuracyPct%',
                      icon: '🎯',
                      color: accuracyColor,
                      animationDelay: 160,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Level progress card
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: _LevelProgressCard(
                level: level,
                levelTitle: levelTitle,
                xp: progress.totalXp,
                levelProgress: levelProgress,
                xpForCurrent: xpForCurrent,
                xpForNext: xpForNext,
              )
                  .animate(delay: 200.ms)
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: 0.08, duration: 500.ms),
            ),
          ),

          // Streak calendar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: _SectionCard(
                title: 'Actividad — últimos 30 días',
                child: StreakCalendar(activityDates: const []),
              )
                  .animate(delay: 280.ms)
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: 0.08, duration: 500.ms),
            ),
          ),

          // Category performance
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: _SectionCard(
                title: 'Categorías',
                child: Column(
                  children: AppCategories.all.asMap().entries.map((e) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _CategoryBar(
                        category: e.value,
                        xp: 0,
                        progress: 0.0,
                        index: e.key,
                      ),
                    );
                  }).toList(),
                ),
              )
                  .animate(delay: 360.ms)
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: 0.08, duration: 500.ms),
            ),
          ),

          // Challenge history
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: _SectionCard(
                title: 'Historial de desafíos',
                child: Column(
                  children: [
                    _HistoryRow(
                      icon: '🏆',
                      label: 'Mejor racha',
                      value: '${progress.bestStreak} días',
                      color: AppColors.secondary,
                    ),
                    const SizedBox(height: 10),
                    _HistoryRow(
                      icon: '📝',
                      label: 'Preguntas respondidas',
                      value: '${progress.totalQuestionsAnswered}',
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: 10),
                    _HistoryRow(
                      icon: '✅',
                      label: 'Respuestas correctas',
                      value: '${progress.totalCorrectAnswers}',
                      color: AppColors.correct,
                    ),
                    const SizedBox(height: 10),
                    _HistoryRow(
                      icon: '🔥',
                      label: 'Racha actual',
                      value: '${progress.currentStreak} días',
                      color: AppColors.secondary,
                    ),
                  ],
                ),
              )
                  .animate(delay: 440.ms)
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: 0.08, duration: 500.ms),
            ),
          ),

          // Achievements
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: _SectionCard(
                title: 'Logros',
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: achievements.length,
                  itemBuilder: (context, i) => _AchievementBadge(
                    achievement: achievements[i],
                    index: i,
                  ),
                ),
              )
                  .animate(delay: 520.ms)
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: 0.08, duration: 500.ms),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Level Progress Card
// ─────────────────────────────────────────────────────────────────────────────

class _LevelProgressCard extends StatelessWidget {
  const _LevelProgressCard({
    required this.level,
    required this.levelTitle,
    required this.xp,
    required this.levelProgress,
    required this.xpForCurrent,
    required this.xpForNext,
  });

  final int level;
  final String levelTitle;
  final int xp;
  final double levelProgress;
  final int xpForCurrent;
  final int xpForNext;

  @override
  Widget build(BuildContext context) {
    final xpToNext = xpForNext - xp;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E1E40), Color(0xFF12122A)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.12),
            blurRadius: 24,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primaryLight, AppColors.primaryDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    '$level',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nivel $level · $levelTitle',
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$xp XP total',
                      style: const TextStyle(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: levelProgress.clamp(0.0, 1.0),
              minHeight: 8,
              backgroundColor: AppColors.border,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${xp - xpForCurrent} XP en este nivel',
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
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section Card
// ─────────────────────────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Category Bar
// ─────────────────────────────────────────────────────────────────────────────

class _CategoryBar extends StatelessWidget {
  const _CategoryBar({
    required this.category,
    required this.xp,
    required this.progress,
    required this.index,
  });

  final CategoryModel category;
  final int xp;
  final double progress;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(category.emoji, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    category.name,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '$xp XP',
                    style: TextStyle(
                      color: category.color,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 5,
                  backgroundColor: AppColors.border,
                  valueColor: AlwaysStoppedAnimation<Color>(category.color),
                ),
              ),
            ],
          ),
        ),
      ],
    )
        .animate(delay: Duration(milliseconds: 60 * index))
        .fadeIn(duration: 300.ms)
        .slideX(begin: 0.05, duration: 300.ms);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// History Row
// ─────────────────────────────────────────────────────────────────────────────

class _HistoryRow extends StatelessWidget {
  const _HistoryRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final String icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Center(child: Text(icon, style: const TextStyle(fontSize: 16))),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Achievement Badge
// ─────────────────────────────────────────────────────────────────────────────

class _Achievement {
  const _Achievement({
    required this.emoji,
    required this.label,
    required this.desc,
    required this.unlocked,
  });

  final String emoji;
  final String label;
  final String desc;
  final bool unlocked;
}

class _AchievementBadge extends StatelessWidget {
  const _AchievementBadge({required this.achievement, required this.index});

  final _Achievement achievement;
  final int index;

  @override
  Widget build(BuildContext context) {
    final color = achievement.unlocked ? AppColors.secondary : AppColors.textTertiary;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: achievement.unlocked
            ? AppColors.secondary.withOpacity(0.08)
            : AppColors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: achievement.unlocked
              ? AppColors.secondary.withOpacity(0.4)
              : AppColors.border,
        ),
        boxShadow: achievement.unlocked
            ? [
                BoxShadow(
                  color: AppColors.secondary.withOpacity(0.15),
                  blurRadius: 8,
                ),
              ]
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            achievement.emoji,
            style: TextStyle(
              fontSize: 26,
              color: achievement.unlocked ? null : const Color(0xFF475569),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            achievement.label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            achievement.desc,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textTertiary,
              fontSize: 9,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    )
        .animate(delay: Duration(milliseconds: 60 * index))
        .fadeIn(duration: 300.ms)
        .scaleXY(begin: 0.85, duration: 300.ms, curve: Curves.easeOut);
  }
}
