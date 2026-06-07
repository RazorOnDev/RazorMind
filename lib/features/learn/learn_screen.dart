import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:razor_mind/core/constants/app_colors.dart';
import 'package:razor_mind/data/models/category_model.dart';
import 'package:razor_mind/data/models/question.dart';
import 'package:razor_mind/data/providers/progress_provider.dart';
import 'package:razor_mind/data/providers/question_provider.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Learning Screen
// ─────────────────────────────────────────────────────────────────────────────

class LearningScreen extends ConsumerWidget {
  const LearningScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(progressProvider);
    final categories = AppCategories.all;

    // Categories with zero XP — suggest to try them
    final untriedCategories = categories
        .where((c) => (progress.categoryXP[c.id] ?? 0) == 0)
        .take(3)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ─── App Bar ────────────────────────────────────────────────────
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.background,
            elevation: 0,
            title: const Text(
              'Aprende',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
                fontSize: 22,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(height: 1, color: AppColors.border),
            ),
          ),

          // ─── Category Progress Summary ───────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Tu progreso',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: categories.asMap().entries.map((e) {
                        final cat = e.value;
                        final xp = progress.categoryXP[cat.id] ?? 0;
                        final accuracy = progress.categoryAccuracy(cat.id);
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: _CategoryProgressChip(
                            category: cat,
                            xp: xp,
                            accuracy: accuracy,
                            index: e.key,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ).animate(delay: 80.ms).fadeIn(duration: 400.ms),
            ),
          ),

          // ─── "Empieza a aprender" (only when untried categories exist) ──
          if (untriedCategories.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: _SuggestionsSection(categories: untriedCategories),
              ).animate(delay: 140.ms).fadeIn(duration: 400.ms).slideY(begin: 0.08, duration: 400.ms),
            ),

          // ─── All Categories section title ────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
              child: const Text(
                'Todas las categorías',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                ),
              ).animate(delay: 160.ms).fadeIn(duration: 300.ms),
            ),
          ),

          // ─── Category Grid ───────────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final cat = categories[index];
                  return _CategoryCard(
                    category: cat,
                    index: index,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      context.push('/learn/${cat.id}');
                    },
                  );
                },
                childCount: categories.length,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Category Progress Chip (horizontal scroll item)
// ─────────────────────────────────────────────────────────────────────────────

class _CategoryProgressChip extends StatelessWidget {
  const _CategoryProgressChip({
    required this.category,
    required this.xp,
    required this.accuracy,
    required this.index,
  });

  final CategoryModel category;
  final int xp;
  final double accuracy;
  final int index;

  @override
  Widget build(BuildContext context) {
    final hasData = xp > 0;
    final accuracyPct = (accuracy * 100).round();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: hasData ? category.color.withOpacity(0.12) : AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: hasData ? category.color.withOpacity(0.4) : AppColors.border,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(category.emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                category.name,
                style: TextStyle(
                  color: hasData ? AppColors.textPrimary : AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              if (hasData) ...[
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      '$xp XP',
                      style: TextStyle(
                        color: category.color,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                    ),
                    const Text(
                      ' · ',
                      style: TextStyle(color: AppColors.textTertiary, fontSize: 10),
                    ),
                    Text(
                      '$accuracyPct%',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: LinearProgressIndicator(
                      value: accuracy.clamp(0.0, 1.0),
                      minHeight: 3,
                      backgroundColor: AppColors.border,
                      valueColor: AlwaysStoppedAnimation<Color>(category.color),
                    ),
                  ),
                ),
              ] else
                const Text(
                  'Sin empezar',
                  style: TextStyle(color: AppColors.textTertiary, fontSize: 10),
                ),
            ],
          ),
        ],
      ),
    ).animate(delay: Duration(milliseconds: 40 * index)).fadeIn(duration: 300.ms);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Suggestions Section ("Empieza a aprender")
// ─────────────────────────────────────────────────────────────────────────────

class _SuggestionsSection extends StatelessWidget {
  const _SuggestionsSection({required this.categories});

  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  '¡NUEVO!',
                  style: TextStyle(
                    color: AppColors.primaryLight,
                    fontWeight: FontWeight.w800,
                    fontSize: 10,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Empieza a aprender',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...categories.map((cat) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _SuggestionRow(category: cat),
              )),
        ],
      ),
    );
  }
}

class _SuggestionRow extends ConsumerWidget {
  const _SuggestionRow({required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.watch(questionsByCategoryProvider(category.id));

    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: category.color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(category.emoji, style: const TextStyle(fontSize: 20)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.name,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              Text(
                '${questions.length} preguntas disponibles',
                style: const TextStyle(
                  color: AppColors.textTertiary,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            context.push('/learn/${category.id}');
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: category.color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: category.color.withOpacity(0.3)),
            ),
            child: Text(
              'Explorar',
              style: TextStyle(
                color: category.color,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Category Card (Grid item — rich with real data)
// ─────────────────────────────────────────────────────────────────────────────

class _CategoryCard extends ConsumerWidget {
  const _CategoryCard({
    required this.category,
    required this.index,
    required this.onTap,
  });

  final CategoryModel category;
  final int index;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.watch(questionsByCategoryProvider(category.id));
    final progress = ref.watch(progressProvider);
    final xp = progress.categoryXP[category.id] ?? 0;
    final accuracy = progress.categoryAccuracy(category.id);
    final accuracyPct = (accuracy * 100).round();
    final hasData = xp > 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: category.color.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Color accent top bar
            Container(
              height: 4,
              decoration: BoxDecoration(
                color: category.color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Emoji + Name row
                    Row(
                      children: [
                        Text(category.emoji, style: const TextStyle(fontSize: 28)),
                        const Spacer(),
                        if (hasData)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                            decoration: BoxDecoration(
                              color: category.color.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '$xp XP',
                              style: TextStyle(
                                color: category.color,
                                fontWeight: FontWeight.w700,
                                fontSize: 10,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      category.name,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      category.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                        height: 1.4,
                      ),
                    ),
                    const Spacer(),
                    // Bottom row: questions + XP/accuracy
                    Row(
                      children: [
                        Text(
                          '${questions.length} preguntas',
                          style: const TextStyle(
                            color: AppColors.textTertiary,
                            fontSize: 10,
                          ),
                        ),
                        if (hasData) ...[
                          const Text(
                            ' · ',
                            style: TextStyle(color: AppColors.textTertiary, fontSize: 10),
                          ),
                          Text(
                            '$accuracyPct%',
                            style: TextStyle(
                              color: accuracy >= 0.7
                                  ? AppColors.correct
                                  : accuracy >= 0.4
                                      ? AppColors.secondary
                                      : AppColors.error,
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (hasData) ...[
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: LinearProgressIndicator(
                          value: accuracy.clamp(0.0, 1.0),
                          minHeight: 4,
                          backgroundColor: AppColors.border,
                          valueColor: AlwaysStoppedAnimation<Color>(category.color),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ).animate(delay: Duration(milliseconds: 80 + index * 60))
          .fadeIn(duration: 400.ms)
          .slideY(begin: 0.12, duration: 400.ms, curve: Curves.easeOut),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Category Detail Screen
// ─────────────────────────────────────────────────────────────────────────────

class CategoryDetailScreen extends ConsumerWidget {
  const CategoryDetailScreen({super.key, required this.categoryId});

  final String categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = AppCategories.getById(categoryId);
    final progress = ref.watch(progressProvider);
    final questions = ref.watch(questionsByCategoryProvider(categoryId));

    final catXp = progress.categoryXP[categoryId] ?? 0;
    final catAccuracy = progress.categoryAccuracy(categoryId);
    final catAttempted = progress.categoryAttempted[categoryId] ?? 0;
    final accuracyPct = (catAccuracy * 100).round();

    final easy = questions.where((q) => q.difficulty == 1).toList();
    final medium = questions.where((q) => q.difficulty == 2).toList();
    final hard = questions.where((q) => q.difficulty == 3).toList();

    final accuracyColor = catAccuracy >= 0.7
        ? AppColors.correct
        : catAccuracy >= 0.4
            ? AppColors.secondary
            : catAccuracy > 0
                ? AppColors.error
                : AppColors.textTertiary;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ─── Colored SliverAppBar ──────────────────────────────────────
          SliverAppBar(
            pinned: true,
            expandedHeight: 150,
            backgroundColor: AppColors.background,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
              onPressed: () => context.pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      category.color.withOpacity(0.22),
                      AppColors.background,
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(72, 12, 24, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${category.emoji}  ${category.name}',
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w800,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          category.description,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ─── Per-Category Stats ────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  _MiniStat(
                    label: 'Preguntas',
                    value: '${questions.length}',
                    color: category.color,
                  ),
                  const SizedBox(width: 10),
                  _MiniStat(
                    label: 'XP ganado',
                    value: catXp > 0 ? '$catXp XP' : '—',
                    color: AppColors.secondary,
                  ),
                  const SizedBox(width: 10),
                  _MiniStat(
                    label: 'Precisión',
                    value: catAttempted > 0 ? '$accuracyPct%' : '—',
                    color: accuracyColor,
                  ),
                ],
              ).animate(delay: 80.ms).fadeIn(duration: 400.ms),
            ),
          ),

          // ─── Category Accuracy Bar ─────────────────────────────────────
          if (catAttempted > 0)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Tu precisión en esta categoría',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            '$accuracyPct%',
                            style: TextStyle(
                              color: accuracyColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: catAccuracy.clamp(0.0, 1.0),
                          minHeight: 8,
                          backgroundColor: AppColors.border,
                          valueColor: AlwaysStoppedAnimation<Color>(accuracyColor),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '$catAttempted preguntas respondidas',
                        style: const TextStyle(
                          color: AppColors.textTertiary,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ).animate(delay: 120.ms).fadeIn(duration: 400.ms),
              ),
            ),

          // ─── Initiate Challenge CTA ────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  context.push('/challenge?mode=daily&categoryId=$categoryId');
                },
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        category.color,
                        category.color.withOpacity(0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: category.color.withOpacity(0.32),
                        blurRadius: 20,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Iniciar Desafío',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              '${questions.length} preguntas · Dificultad mixta',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.85),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 32),
                    ],
                  ),
                ),
              ).animate(delay: 160.ms).fadeIn(duration: 400.ms).slideY(begin: 0.08, duration: 400.ms),
            ),
          ),

          // ─── Marathon CTA ──────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  context.push('/challenge?mode=marathon&categoryId=$categoryId');
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: category.color.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: category.color.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text('🏃', style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Maratón de categoría',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '30 preguntas · Solo esta categoría',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded,
                          color: AppColors.textTertiary, size: 14),
                    ],
                  ),
                ),
              ).animate(delay: 220.ms).fadeIn(duration: 400.ms),
            ),
          ),

          // ─── Difficulty Breakdown ──────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: _DifficultyBreakdown(
                easy: easy,
                medium: medium,
                hard: hard,
              ).animate(delay: 260.ms).fadeIn(duration: 400.ms),
            ),
          ),

          // ─── Difficulty Sections (question previews) ────────────────────
          if (easy.isNotEmpty)
            _DifficultySection(
              label: 'Fácil',
              color: AppColors.correct,
              questions: easy,
              delay: 300,
            ),
          if (medium.isNotEmpty)
            _DifficultySection(
              label: 'Intermedio',
              color: AppColors.secondary,
              questions: medium,
              delay: 360,
            ),
          if (hard.isNotEmpty)
            _DifficultySection(
              label: 'Difícil',
              color: AppColors.error,
              questions: hard,
              delay: 420,
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Mini Stat Card
// ─────────────────────────────────────────────────────────────────────────────

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.label, required this.value, required this.color});

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
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
              style: const TextStyle(color: AppColors.textTertiary, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Difficulty Breakdown (tag row)
// ─────────────────────────────────────────────────────────────────────────────

class _DifficultyBreakdown extends StatelessWidget {
  const _DifficultyBreakdown({
    required this.easy,
    required this.medium,
    required this.hard,
  });

  final List<Question> easy;
  final List<Question> medium;
  final List<Question> hard;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Distribución de dificultad',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _DifficultyTag(
                label: 'Fácil',
                count: easy.length,
                color: AppColors.correct,
              ),
              const SizedBox(width: 8),
              _DifficultyTag(
                label: 'Intermedio',
                count: medium.length,
                color: AppColors.secondary,
              ),
              const SizedBox(width: 8),
              _DifficultyTag(
                label: 'Difícil',
                count: hard.length,
                color: AppColors.error,
              ),
            ],
          ),
          if (easy.isNotEmpty || medium.isNotEmpty || hard.isNotEmpty) ...[
            const SizedBox(height: 12),
            // Visual bar breakdown
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Row(
                children: [
                  if (easy.isNotEmpty)
                    Expanded(
                      flex: easy.length,
                      child: Container(height: 6, color: AppColors.correct),
                    ),
                  if (medium.isNotEmpty)
                    Expanded(
                      flex: medium.length,
                      child: Container(height: 6, color: AppColors.secondary),
                    ),
                  if (hard.isNotEmpty)
                    Expanded(
                      flex: hard.length,
                      child: Container(height: 6, color: AppColors.error),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DifficultyTag extends StatelessWidget {
  const _DifficultyTag({
    required this.label,
    required this.count,
    required this.color,
  });

  final String label;
  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        '$count $label',
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Difficulty Section (question preview list)
// ─────────────────────────────────────────────────────────────────────────────

class _DifficultySection extends StatelessWidget {
  const _DifficultySection({
    required this.label,
    required this.color,
    required this.questions,
    required this.delay,
  });

  final String label;
  final Color color;
  final List<Question> questions;
  final int delay;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: color.withOpacity(0.3)),
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${questions.length} preguntas',
                  style: const TextStyle(color: AppColors.textTertiary, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...questions.take(3).map((q) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            q.text,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '+${q.xpReward}XP',
                            style: TextStyle(
                              color: color,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            if (questions.length > 3)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  '+ ${questions.length - 3} preguntas más',
                  style: const TextStyle(color: AppColors.textTertiary, fontSize: 12),
                ),
              ),
          ],
        ).animate(delay: Duration(milliseconds: delay)).fadeIn(duration: 400.ms),
      ),
    );
  }
}
