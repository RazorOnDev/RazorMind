import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:razor_mind/core/constants/app_colors.dart';
import 'package:razor_mind/data/models/category_model.dart';
import 'package:razor_mind/data/providers/progress_provider.dart';

class ModeSelectScreen extends ConsumerStatefulWidget {
  const ModeSelectScreen({super.key});

  @override
  ConsumerState<ModeSelectScreen> createState() => _ModeSelectScreenState();
}

class _ModeSelectScreenState extends ConsumerState<ModeSelectScreen> {
  bool _marathonExpanded = false;

  @override
  Widget build(BuildContext context) {
    final progress = ref.watch(progressProvider);
    final dailyDone = progress.completedChallengeIds.contains(_todayKey());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Elige tu modo',
          style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w800, fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Cada modo entrena tu mente diferente',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
              ).animate().fadeIn(duration: 300.ms),
              const SizedBox(height: 20),
              _ModeCard(
                delay: 0,
                gradientColors: const [AppColors.primaryLight, AppColors.primaryDark],
                emoji: '🎯',
                title: 'Desafío Diario',
                description: 'Las mismas 10 preguntas para todos hoy. Compara tu resultado.',
                stats: '10 preguntas · Mixto · Racha',
                isCompleted: dailyDone,
                onTap: () { HapticFeedback.selectionClick(); context.push('/challenge?mode=daily'); },
              ),
              const SizedBox(height: 12),
              _ModeCard(
                delay: 100,
                gradientColors: const [Color(0xFF0EA5E9), Color(0xFF0369A1)],
                emoji: '⚡',
                title: 'Modo Velocidad',
                description: 'Ideal para rapidez mental y ranking. Piensa rápido.',
                stats: '15 segundos · 15 preguntas · +Puntos de rango',
                onTap: () { HapticFeedback.selectionClick(); context.push('/challenge?mode=speed'); },
              ),
              const SizedBox(height: 12),
              _ModeCard(
                delay: 200,
                gradientColors: const [Color(0xFFEF4444), Color(0xFFB91C1C)],
                emoji: '❤️',
                title: 'Supervivencia',
                description: '¿Cuánto puedes aguantar? Pierde 3 vidas y es game over.',
                stats: '3 vidas · Preguntas sin fin',
                onTap: () { HapticFeedback.selectionClick(); context.push('/challenge?mode=survival'); },
              ),
              const SizedBox(height: 12),
              _MarathonCard(
                delay: 300,
                expanded: _marathonExpanded,
                onToggle: () { HapticFeedback.selectionClick(); setState(() => _marathonExpanded = !_marathonExpanded); },
                onCategoryTap: (catId) { HapticFeedback.selectionClick(); context.push('/challenge?mode=marathon&categoryId=$catId'); },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _todayKey() {
    final now = DateTime.now();
    return 'daily_${now.year}_${now.month}_${now.day}';
  }
}

class _ModeCard extends StatelessWidget {
  final int delay;
  final List<Color> gradientColors;
  final String emoji;
  final String title;
  final String description;
  final String stats;
  final bool isCompleted;
  final VoidCallback onTap;

  const _ModeCard({
    required this.delay,
    required this.gradientColors,
    required this.emoji,
    required this.title,
    required this.description,
    required this.stats,
    this.isCompleted = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: gradientColors.last.withOpacity(0.35), blurRadius: 20, offset: const Offset(0, 6))],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(emoji, style: const TextStyle(fontSize: 44)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 4),
                        Text(description, style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 13, height: 1.4)),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                          child: Text(stats, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (!isCompleted) const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 18),
                ],
              ),
            ),
            if (isCompleted)
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(color: AppColors.correct, borderRadius: BorderRadius.circular(20)),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_rounded, color: Colors.white, size: 14),
                      SizedBox(width: 4),
                      Text('Completado hoy', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    ).animate(delay: Duration(milliseconds: delay)).fadeIn(duration: 400.ms).slideY(begin: 0.15, duration: 400.ms, curve: Curves.easeOut);
  }
}

class _MarathonCard extends StatelessWidget {
  final int delay;
  final bool expanded;
  final VoidCallback onToggle;
  final void Function(String categoryId) onCategoryTap;

  const _MarathonCard({
    required this.delay,
    required this.expanded,
    required this.onToggle,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: GestureDetector(
        onTap: onToggle,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF10B981), Color(0xFF047857)],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: const Color(0xFF047857).withOpacity(0.35), blurRadius: 20, offset: const Offset(0, 6))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('🏃', style: TextStyle(fontSize: 44)),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Maratón', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
                          SizedBox(height: 4),
                          Text('Domina una categoría de principio a fin.', style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4)),
                          SizedBox(height: 10),
                          _StatsBadge(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.expand_more_rounded, color: Colors.white, size: 24),
                  ],
                ),
              ),
              if (expanded) ...[  
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                  child: Text('Elige una categoría:', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12, fontWeight: FontWeight.w600)),
                ),
                SizedBox(
                  height: 52,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                    itemCount: AppCategories.all.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, i) {
                      final cat = AppCategories.all[i];
                      return GestureDetector(
                        onTap: () => onCategoryTap(cat.id),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white.withOpacity(0.4)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(cat.emoji, style: const TextStyle(fontSize: 14)),
                              const SizedBox(width: 6),
                              Text(cat.name, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ],
          ),
        ),
      ),
    ).animate(delay: Duration(milliseconds: delay)).fadeIn(duration: 400.ms).slideY(begin: 0.15, duration: 400.ms, curve: Curves.easeOut);
  }
}

class _StatsBadge extends StatelessWidget {
  const _StatsBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
      child: const Text('Elige una categoría · Todas las preguntas', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }
}
