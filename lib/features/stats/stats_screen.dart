import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:razor_mind/core/constants/app_colors.dart';
import 'package:razor_mind/core/utils/level_utils.dart';
import 'package:razor_mind/core/utils/rank_utils.dart';
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

    // Parse activity dates for the streak calendar
    final activeDays = progress.activityDates.map((s) {
      try {
        return DateTime.parse(s);
      } catch (_) {
        return null;
      }
    }).whereType<DateTime>().toList();

    // Sort categories by XP descending
    final sortedCategories = List<CategoryModel>.from(AppCategories.all)
      ..sort((a, b) {
        final xpA = progress.categoryXP[a.id] ?? 0;
        final xpB = progress.categoryXP[b.id] ?? 0;
        return xpB.compareTo(xpA);
      });

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
        desc: '7 días seguidos',
        unlocked: progress.currentStreak >= 7,
      ),
      _Achievement(
        emoji: '📚',
        label: 'Erudito',
        desc: '100 preguntas respondidas',
        unlocked: progress.totalQuestionsAnswered >= 100,
      ),
      _Achievement(
        emoji: '⭐',
        label: 'Maestro',
        desc: '>90% precisión (50+ preguntas)',
        unlocked: progress.correctRate >= 0.9 && progress.totalQuestionsAnswered >= 50,
      ),
      _Achievement(
        emoji: '🌍',
        label: 'Explorador',
        desc: 'XP en 5+ categorías',
        unlocked: progress.categoryXP.values.where((v) => v > 0).length >= 5,
      ),
      _Achievement(
        emoji: '💎',
        label: 'Diamante',
        desc: 'Alcanza rango Diamante',
        unlocked: progress.rankPoints >= 7500,
      ),
      _Achievement(
        emoji: '⚡',
        label: 'Velocista',
        desc: 'Modo Velocidad 5 veces',
        unlocked: progress.completedChallengeIds
                .where((id) => id.contains('speed'))
                .length >=
            5,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ─── Header ────────────────────────────────────────────────────────
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

          // ─── Rank Card ─────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: _RankCard(rankPoints: progress.rankPoints),
            ).animate(delay: 80.ms).fadeIn(duration: 500.ms).slideY(begin: 0.08, duration: 500.ms),
          ),

          // ─── Overall Stats Row ──────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
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

          // ─── Level Progress Card ────────────────────────────────────────
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
              ).animate(delay: 200.ms).fadeIn(duration: 500.ms).slideY(begin: 0.08, duration: 500.ms),
            ),
          ),

          // ─── Streak Calendar ───────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: _SectionCard(
                title: 'Actividad — últimos 30 días',
                child: StreakCalendar(activityDates: activeDays),
              ).animate(delay: 280.ms).fadeIn(duration: 500.ms).slideY(begin: 0.08, duration: 500.ms),
            ),
          ),

          // ─── Category Performance (Horizontal Bar Chart) ───────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: _SectionCard(
                title: 'Rendimiento por categoría',
                child: Column(
                  children: sortedCategories.asMap().entries.map((e) {
                    final cat = e.value;
                    final accuracy = progress.categoryAccuracy(cat.id);
                    final xp = progress.categoryXP[cat.id] ?? 0;
                    final accuracyPctCat = (accuracy * 100).round();
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _CategoryBar(
                        category: cat,
                        xp: xp,
                        accuracy: accuracy,
                        accuracyPct: accuracyPctCat,
                        index: e.key,
                      ),
                    );
                  }).toList(),
                ),
              ).animate(delay: 360.ms).fadeIn(duration: 500.ms).slideY(begin: 0.08, duration: 500.ms),
            ),
          ),

          // ─── Category Accuracy Rings ────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: _SectionCard(
                title: 'Precisión por categoría',
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: AppCategories.all.asMap().entries.map((e) {
                      final cat = e.value;
                      final accuracy = progress.categoryAccuracy(cat.id);
                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: _CircularAccuracy(
                          percent: accuracy,
                          color: cat.color,
                          emoji: cat.emoji,
                          name: cat.name,
                        ).animate(
                          delay: Duration(milliseconds: 50 * e.key),
                        ).fadeIn(duration: 300.ms).scaleXY(begin: 0.8, duration: 300.ms),
                      );
                    }).toList(),
                  ),
                ),
              ).animate(delay: 440.ms).fadeIn(duration: 500.ms).slideY(begin: 0.08, duration: 500.ms),
            ),
          ),

          // ─── Achievements ───────────────────────────────────────────────
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
              ).animate(delay: 520.ms).fadeIn(duration: 500.ms).slideY(begin: 0.08, duration: 500.ms),
            ),
          ),

          // ─── Personal Records ────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: _SectionCard(
                title: 'Récords personales',
                child: Column(
                  children: [
                    _RecordRow(
                      icon: '🏆',
                      label: 'Racha más larga',
                      value: '${progress.bestStreak} días',
                      color: AppColors.secondary,
                    ),
                    const SizedBox(height: 10),
                    _RecordRow(
                      icon: '✅',
                      label: 'Respuestas seguidas correctas',
                      value: '${progress.longestCorrectStreak}',
                      color: AppColors.correct,
                    ),
                    const SizedBox(height: 10),
                    _RecordRow(
                      icon: '⚡',
                      label: 'XP total ganado',
                      value: '${progress.totalXp} XP',
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: 10),
                    _RecordRow(
                      icon: '🎯',
                      label: 'Desafíos completados',
                      value: '${progress.completedChallengeIds.length}',
                      color: AppColors.primaryLight,
                    ),
                  ],
                ),
              ).animate(delay: 600.ms).fadeIn(duration: 500.ms).slideY(begin: 0.08, duration: 500.ms),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Rank Card
// ─────────────────────────────────────────────────────────────────────────────

class _RankCard extends StatelessWidget {
  const _RankCard({required this.rankPoints});

  final int rankPoints;

  @override
  Widget build(BuildContext context) {
    final rankName = RankUtils.getRankName(rankPoints);
    final rankEmoji = RankUtils.getRankEmoji(rankPoints);
    final rankColor = RankUtils.getRankColor(rankPoints);
    final rankProgress = RankUtils.getRankProgress(rankPoints);
    final nextRankName = RankUtils.getNextRankName(rankPoints);

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        context.push('/ranking');
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              rankColor.withOpacity(0.18),
              AppColors.card,
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: rankColor.withOpacity(0.35), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: rankColor.withOpacity(0.12),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(rankEmoji, style: const TextStyle(fontSize: 36)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        rankName,
                        style: TextStyle(
                          color: rankColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '· $rankPoints pts',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: rankProgress.clamp(0.0, 1.0),
                      minHeight: 6,
                      backgroundColor: AppColors.border,
                      valueColor: AlwaysStoppedAnimation<Color>(rankColor),
                    ),
                  ),
                  if (nextRankName != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Siguiente: $nextRankName',
                      style: const TextStyle(
                        color: AppColors.textTertiary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary),
          ],
        ),
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
// Category Bar (Horizontal progress bar with accuracy + XP)
// ─────────────────────────────────────────────────────────────────────────────

class _CategoryBar extends StatelessWidget {
  const _CategoryBar({
    required this.category,
    required this.xp,
    required this.accuracy,
    required this.accuracyPct,
    required this.index,
  });

  final CategoryModel category;
  final int xp;
  final double accuracy;
  final int accuracyPct;
  final int index;

  @override
  Widget build(BuildContext context) {
    final hasData = xp > 0 || accuracy > 0;
    return Row(
      children: [
        Text(category.emoji, style: const TextStyle(fontSize: 20)),
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
                  Row(
                    children: [
                      Text(
                        hasData ? '$accuracyPct%' : '—',
                        style: TextStyle(
                          color: hasData ? category.color : AppColors.textTertiary,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        hasData ? '$xp XP' : 'Sin datos',
                        style: TextStyle(
                          color: hasData ? AppColors.textSecondary : AppColors.textTertiary,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5),
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: LinearProgressIndicator(
                  value: hasData ? accuracy.clamp(0.0, 1.0) : 0.0,
                  minHeight: 6,
                  backgroundColor: AppColors.border,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    hasData ? category.color : AppColors.textTertiary.withOpacity(0.3),
                  ),
                ),
              ),
              if (!hasData)
                const Padding(
                  padding: EdgeInsets.only(top: 3),
                  child: Text(
                    'Sin datos aún',
                    style: TextStyle(color: AppColors.textTertiary, fontSize: 10),
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
// Circular Accuracy Ring (Custom Painter)
// ─────────────────────────────────────────────────────────────────────────────

class _CircularAccuracy extends StatelessWidget {
  const _CircularAccuracy({
    required this.percent,
    required this.color,
    required this.emoji,
    required this.name,
  });

  final double percent; // 0.0 to 1.0
  final Color color;
  final String emoji;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 64,
          height: 64,
          child: CustomPaint(
            painter: _RingPainter(
              percent: percent.clamp(0.0, 1.0),
              color: color,
              backgroundColor: AppColors.border,
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 22)),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          percent > 0 ? '${(percent * 100).round()}%' : '—',
          style: TextStyle(
            color: percent > 0 ? color : AppColors.textTertiary,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 2),
        SizedBox(
          width: 64,
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textTertiary,
              fontSize: 9,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.percent,
    required this.color,
    required this.backgroundColor,
  });

  final double percent;
  final Color color;
  final Color backgroundColor;

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 5.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - strokeWidth / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Background ring
    final bgPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);

    // Progress arc
    if (percent > 0) {
      final fgPaint = Paint()
        ..color = color
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(
        rect,
        -math.pi / 2,        // start at top
        2 * math.pi * percent, // sweep angle
        false,
        fgPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.percent != percent || old.color != color;
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

// ─────────────────────────────────────────────────────────────────────────────
// Record Row
// ─────────────────────────────────────────────────────────────────────────────

class _RecordRow extends StatelessWidget {
  const _RecordRow({
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
