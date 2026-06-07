import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:razor_mind/core/constants/app_colors.dart';
import 'package:razor_mind/core/utils/rank_utils.dart';
import 'package:razor_mind/data/providers/progress_provider.dart';

class RankingScreen extends ConsumerWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(progressProvider);
    final rankPoints = progress.rankPoints;
    final rankIndex = RankUtils.getRankIndex(rankPoints);
    final rankName = RankUtils.getRankName(rankPoints);
    final rankEmoji = RankUtils.getRankEmoji(rankPoints);
    final rankColor = RankUtils.getRankColor(rankPoints);
    final rankProgress = RankUtils.getRankProgress(rankPoints);
    final nextThreshold = RankUtils.getNextRankThreshold(rankPoints);
    final nextRankName = RankUtils.getNextRankName(rankPoints);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ─── Header ────────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                24,
                MediaQuery.of(context).padding.top + 20,
                24,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: const Icon(
                            Icons.arrow_back_rounded,
                            color: AppColors.textPrimary,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Liga y Rango',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w800,
                              fontSize: 26,
                            ),
                          ),
                          const Text(
                            'Progresa y conquista cada rango',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms),
          ),

          // ─── Current Rank Hero Card ─────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: _RankHeroCard(
                rankIndex: rankIndex,
                rankName: rankName,
                rankEmoji: rankEmoji,
                rankColor: rankColor,
                rankProgress: rankProgress,
                rankPoints: rankPoints,
                nextThreshold: nextThreshold,
                nextRankName: nextRankName,
              ),
            ).animate(delay: 100.ms).fadeIn(duration: 500.ms).slideY(begin: 0.08, duration: 500.ms),
          ),

          // ─── Rank Ladder ───────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Escalera de rangos',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 14),
                  ...List.generate(RankUtils.names.length, (i) {
                    final isReached = rankIndex >= i;
                    final isCurrent = rankIndex == i;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _RankLadderItem(
                        index: i,
                        rankPoints: rankPoints,
                        isReached: isReached,
                        isCurrent: isCurrent,
                        staggerIndex: i,
                      ),
                    );
                  }),
                ],
              ),
            ).animate(delay: 200.ms).fadeIn(duration: 500.ms),
          ),

          // ─── Speed Mode Bonus Section ───────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: _SpeedModeCard(rankPoints: rankPoints),
            ).animate(delay: 360.ms).fadeIn(duration: 500.ms).slideY(begin: 0.08, duration: 500.ms),
          ),

          // ─── Rank Descriptions ──────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: _RankDescriptionsCard(currentRankIndex: rankIndex),
            ).animate(delay: 440.ms).fadeIn(duration: 500.ms).slideY(begin: 0.08, duration: 500.ms),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Rank Hero Card
// ─────────────────────────────────────────────────────────────────────────────

class _RankHeroCard extends StatelessWidget {
  const _RankHeroCard({
    required this.rankIndex,
    required this.rankName,
    required this.rankEmoji,
    required this.rankColor,
    required this.rankProgress,
    required this.rankPoints,
    required this.nextThreshold,
    required this.nextRankName,
  });

  final int rankIndex;
  final String rankName;
  final String rankEmoji;
  final Color rankColor;
  final double rankProgress;
  final int rankPoints;
  final int nextThreshold;
  final String? nextRankName;

  @override
  Widget build(BuildContext context) {
    final isMaxRank = rankIndex >= RankUtils.thresholds.length - 1;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            rankColor.withOpacity(0.25),
            rankColor.withOpacity(0.08),
            AppColors.card,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: rankColor.withOpacity(0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: rankColor.withOpacity(0.2),
            blurRadius: 32,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Emoji
          Text(
            rankEmoji,
            style: const TextStyle(fontSize: 64),
          )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scaleXY(begin: 0.95, end: 1.05, duration: 2000.ms, curve: Curves.easeInOut),
          const SizedBox(height: 12),
          // Rank name
          Text(
            rankName,
            style: TextStyle(
              color: rankColor,
              fontWeight: FontWeight.w800,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '$rankPoints Puntos de Rango',
            style: TextStyle(
              color: AppColors.secondary,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: rankProgress.clamp(0.0, 1.0),
              minHeight: 10,
              backgroundColor: AppColors.border,
              valueColor: AlwaysStoppedAnimation<Color>(rankColor),
            ),
          ),
          const SizedBox(height: 10),
          if (!isMaxRank && nextRankName != null)
            Text(
              '$rankPoints / $nextThreshold puntos para $nextRankName',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            )
          else
            Text(
              'Rango máximo alcanzado',
              style: TextStyle(
                color: rankColor,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Rank Ladder Item
// ─────────────────────────────────────────────────────────────────────────────

class _RankLadderItem extends StatelessWidget {
  const _RankLadderItem({
    required this.index,
    required this.rankPoints,
    required this.isReached,
    required this.isCurrent,
    required this.staggerIndex,
  });

  final int index;
  final int rankPoints;
  final bool isReached;
  final bool isCurrent;
  final int staggerIndex;

  @override
  Widget build(BuildContext context) {
    final rankColor = RankUtils.colors[index];
    final emoji = RankUtils.emojis[index];
    final name = RankUtils.names[index];
    final threshold = RankUtils.thresholds[index];

    Widget content = AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isCurrent
            ? rankColor.withOpacity(0.12)
            : isReached
                ? AppColors.card
                : AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCurrent
              ? rankColor.withOpacity(0.6)
              : isReached
                  ? AppColors.borderLight
                  : AppColors.border,
          width: isCurrent ? 1.5 : 1,
        ),
        boxShadow: isCurrent
            ? [
                BoxShadow(
                  color: rankColor.withOpacity(0.15),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          // Rank emoji circle
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isReached
                  ? rankColor.withOpacity(0.2)
                  : AppColors.border.withOpacity(0.3),
              border: Border.all(
                color: isReached ? rankColor.withOpacity(0.5) : AppColors.border,
              ),
            ),
            child: Center(
              child: Text(
                emoji,
                style: TextStyle(
                  fontSize: 20,
                  color: isReached ? null : const Color(0xFF475569),
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          // Name + threshold
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: isReached ? rankColor : AppColors.textTertiary,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  threshold == 0 ? 'Inicio' : '$threshold pts requeridos',
                  style: const TextStyle(
                    color: AppColors.textTertiary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          // Status badge
          if (isCurrent) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: rankColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: rankColor.withOpacity(0.4)),
              ),
              child: Text(
                'TÚ',
                style: TextStyle(
                  color: rankColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ] else if (isReached) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.correct.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle_rounded, color: AppColors.correct, size: 14),
                  SizedBox(width: 4),
                  Text(
                    'Alcanzado',
                    style: TextStyle(
                      color: AppColors.correct,
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.border.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('🔒', style: TextStyle(fontSize: 12)),
                  SizedBox(width: 4),
                  Text(
                    'Bloqueado',
                    style: TextStyle(
                      color: AppColors.textTertiary,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );

    return content
        .animate(delay: Duration(milliseconds: 60 * staggerIndex))
        .fadeIn(duration: 300.ms)
        .slideX(begin: 0.06, duration: 300.ms);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Speed Mode Card
// ─────────────────────────────────────────────────────────────────────────────

class _SpeedModeCard extends StatelessWidget {
  const _SpeedModeCard({required this.rankPoints});

  final int rankPoints;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E1A40), Color(0xFF12121E)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.1),
            blurRadius: 20,
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
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text('⚡', style: TextStyle(fontSize: 22)),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gana Puntos de Rango',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Juega en Modo Velocidad para subir',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Juega en Modo Velocidad para ganar puntos de rango y subir en la clasificación. Cada respuesta correcta bajo presión cuenta.',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    context.push('/challenge?mode=speed');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.primaryLight, AppColors.primaryDark],
                      ),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('⚡', style: TextStyle(fontSize: 16)),
                        SizedBox(width: 8),
                        Text(
                          'Jugar Modo Velocidad →',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star_rounded, color: AppColors.secondary, size: 14),
              const SizedBox(width: 4),
              Text(
                'Puntos de rango actuales: $rankPoints',
                style: const TextStyle(
                  color: AppColors.secondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Rank Descriptions Card
// ─────────────────────────────────────────────────────────────────────────────

class _RankDescriptionsCard extends StatelessWidget {
  const _RankDescriptionsCard({required this.currentRankIndex});

  final int currentRankIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Descripción de rangos',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 14),
          ...List.generate(RankUtils.names.length, (i) {
            final isReached = currentRankIndex >= i;
            final isCurrent = currentRankIndex == i;
            final rankColor = RankUtils.colors[i];

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Text(
                    RankUtils.emojis[i],
                    style: TextStyle(
                      fontSize: 18,
                      color: isReached ? null : const Color(0xFF475569),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      RankUtils.descriptions[i],
                      style: TextStyle(
                        color: isCurrent
                            ? rankColor
                            : isReached
                                ? AppColors.textSecondary
                                : AppColors.textTertiary,
                        fontSize: 13,
                        fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                  if (isCurrent)
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: rankColor,
                        boxShadow: [
                          BoxShadow(
                            color: rankColor.withOpacity(0.6),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    )
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .scaleXY(begin: 0.7, end: 1.3, duration: 1000.ms),
                ],
              )
                  .animate(delay: Duration(milliseconds: 40 * i))
                  .fadeIn(duration: 300.ms),
            );
          }),
        ],
      ),
    );
  }
}
