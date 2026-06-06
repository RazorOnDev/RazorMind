import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razor_mind/core/constants/app_colors.dart';
import 'package:razor_mind/core/constants/app_strings.dart';
import 'package:razor_mind/core/utils/level_utils.dart';
import 'package:razor_mind/data/providers/progress_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(progressProvider);
    final level = LevelUtils.getLevel(progress.totalXp);
    final levelTitle = LevelUtils.getLevelTitle(level);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.myProfile),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            // Avatar + level badge
            Center(
              child: Column(
                children: [
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColors.primaryLight, AppColors.primaryDark],
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 44),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    levelTitle,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${AppStrings.level} $level · ${progress.totalXp} ${AppStrings.xp}',
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const _SectionDivider(label: 'Progreso'),
            const SizedBox(height: 16),
            _InfoRow(label: AppStrings.totalXp, value: '${progress.totalXp} XP'),
            _InfoRow(label: AppStrings.currentStreak, value: '${progress.currentStreak} ${AppStrings.days}'),
            _InfoRow(label: AppStrings.bestStreak, value: '${progress.bestStreak} ${AppStrings.days}'),
            _InfoRow(label: AppStrings.totalQuestions, value: '${progress.totalQuestionsAnswered}'),
            _InfoRow(
              label: AppStrings.correctRate,
              value: '${(progress.correctRate * 100).round()}%',
            ),
            const SizedBox(height: 32),
            const _SectionDivider(label: 'Ajustes'),
            const SizedBox(height: 16),
            _DangerButton(
              label: AppStrings.resetProgress,
              onPressed: () => _showResetDialog(context, ref),
            ),
          ],
        ),
      ),
    );
  }

  void _showResetDialog(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          AppStrings.resetProgress,
          style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700),
        ),
        content: const Text(
          AppStrings.resetConfirm,
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(AppStrings.cancel, style: TextStyle(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () {
              ref.read(progressProvider.notifier).resetProgress();
              Navigator.of(ctx).pop();
            },
            child: const Text(AppStrings.confirm, style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textTertiary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(child: Divider(color: AppColors.border, thickness: 1, height: 1)),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 15)),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _DangerButton extends StatelessWidget {
  const _DangerButton({required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.error.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.error.withOpacity(0.25)),
        ),
        child: Row(
          children: [
            const Icon(Icons.delete_outline_rounded, color: AppColors.error, size: 20),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(color: AppColors.error, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
