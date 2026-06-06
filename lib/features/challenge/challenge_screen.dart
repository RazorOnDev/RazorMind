import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:razor_mind/core/constants/app_colors.dart';
import 'package:razor_mind/core/constants/app_strings.dart';
import 'package:razor_mind/core/utils/level_utils.dart';
import 'package:razor_mind/data/providers/progress_provider.dart';

// ---------------------------------------------------------------------------
// Minimal inline question model for the challenge
// ---------------------------------------------------------------------------

class _Question {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String category;

  const _Question({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.category,
  });
}

const _sampleQuestions = [
  _Question(
    question: '¿En qué año llegó el ser humano por primera vez a la Luna?',
    options: ['1965', '1969', '1972', '1961'],
    correctIndex: 1,
    category: 'history',
  ),
  _Question(
    question: '¿Cuál es el planeta más grande del sistema solar?',
    options: ['Saturno', 'Urano', 'Júpiter', 'Neptuno'],
    correctIndex: 2,
    category: 'science',
  ),
  _Question(
    question: '¿Cuál es la capital de Australia?',
    options: ['Sídney', 'Melbourne', 'Brisbane', 'Canberra'],
    correctIndex: 3,
    category: 'geography',
  ),
  _Question(
    question: '¿Quién pintó la Capilla Sixtina?',
    options: ['Leonardo da Vinci', 'Rafael', 'Botticelli', 'Miguel Ángel'],
    correctIndex: 3,
    category: 'art',
  ),
  _Question(
    question: '¿En qué año fue fundada la empresa Apple?',
    options: ['1974', '1976', '1980', '1984'],
    correctIndex: 1,
    category: 'tech',
  ),
  _Question(
    question: '¿Quién escribió "El origen de las especies"?',
    options: ['Isaac Newton', 'Albert Einstein', 'Charles Darwin', 'Gregor Mendel'],
    correctIndex: 2,
    category: 'science',
  ),
  _Question(
    question: '¿Cuántos países conforman África?',
    options: ['48', '52', '54', '57'],
    correctIndex: 2,
    category: 'geography',
  ),
  _Question(
    question: '¿Quién propuso la teoría de la relatividad especial?',
    options: ['Nikola Tesla', 'Albert Einstein', 'Max Planck', 'Niels Bohr'],
    correctIndex: 1,
    category: 'science',
  ),
  _Question(
    question: '¿En qué siglo vivió Sócrates?',
    options: ['Siglo IV a.C.', 'Siglo V a.C.', 'Siglo III a.C.', 'Siglo VI a.C.'],
    correctIndex: 1,
    category: 'philosophy',
  ),
  _Question(
    question: '¿Cuántas lenguas oficiales tiene la ONU?',
    options: ['4', '5', '6', '7'],
    correctIndex: 2,
    category: 'language',
  ),
];

// ---------------------------------------------------------------------------
// ChallengeScreen
// ---------------------------------------------------------------------------

class ChallengeScreen extends ConsumerStatefulWidget {
  const ChallengeScreen({super.key});

  @override
  ConsumerState<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends ConsumerState<ChallengeScreen> {
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedAnswer;
  bool _answered = false;

  _Question get _current => _sampleQuestions[_currentIndex];

  void _selectAnswer(int index) {
    if (_answered) return;
    setState(() {
      _selectedAnswer = index;
      _answered = true;
      if (index == _current.correctIndex) _score++;
    });
  }

  void _next() {
    if (_currentIndex < _sampleQuestions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedAnswer = null;
        _answered = false;
      });
    } else {
      _finish();
    }
  }

  Future<void> _finish() async {
    final xpEarned = LevelUtils.calculateXpReward(
      correctAnswers: _score,
      totalQuestions: _sampleQuestions.length,
      isStreakActive: ref.read(progressProvider).currentStreak > 0,
    );
    await ref.read(progressProvider.notifier).recordSession(
          xpEarned: xpEarned,
          questionsAnswered: _sampleQuestions.length,
          correctAnswers: _score,
        );
    if (mounted) {
      context.go(
        '/challenge/result'
        '?score=$_score'
        '&total=${_sampleQuestions.length}'
        '&xpEarned=$xpEarned'
        '&categoryId=general',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = _sampleQuestions.length;
    final progress = (_currentIndex + 1) / total;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.go('/home'),
        ),
        title: Text(
          '${AppStrings.question} ${_currentIndex + 1} ${AppStrings.of} $total',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '$_score/$total',
                style: const TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress bar
            LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.border,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              minHeight: 4,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      _current.question,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                            height: 1.4,
                          ),
                    ).animate(key: ValueKey(_currentIndex)).fadeIn(duration: 400.ms),
                    const SizedBox(height: 32),
                    ...List.generate(_current.options.length, (i) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _AnswerOption(
                          label: _current.options[i],
                          index: i,
                          selectedIndex: _selectedAnswer,
                          correctIndex: _answered ? _current.correctIndex : null,
                          onTap: () => _selectAnswer(i),
                          animDelay: Duration(milliseconds: 100 + i * 60),
                          questionKey: _currentIndex,
                        ),
                      );
                    }),
                    const Spacer(),
                    if (_answered)
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                          ),
                          onPressed: _next,
                          child: Text(
                            _currentIndex == total - 1
                                ? AppStrings.finish
                                : AppStrings.continueLabel,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.2, duration: 300.ms),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnswerOption extends StatelessWidget {
  const _AnswerOption({
    required this.label,
    required this.index,
    required this.selectedIndex,
    required this.correctIndex,
    required this.onTap,
    required this.animDelay,
    required this.questionKey,
  });

  final String label;
  final int index;
  final int? selectedIndex;
  final int? correctIndex;
  final VoidCallback onTap;
  final Duration animDelay;
  final int questionKey;

  Color _getColor() {
    if (correctIndex == null) return AppColors.card;
    if (index == correctIndex) return AppColors.correct.withOpacity(0.15);
    if (index == selectedIndex && selectedIndex != correctIndex) {
      return AppColors.error.withOpacity(0.15);
    }
    return AppColors.card;
  }

  Color _getBorderColor() {
    if (correctIndex == null) return AppColors.border;
    if (index == correctIndex) return AppColors.correct;
    if (index == selectedIndex && selectedIndex != correctIndex) return AppColors.error;
    return AppColors.border;
  }

  Color _getTextColor() {
    if (correctIndex == null) return AppColors.textPrimary;
    if (index == correctIndex) return AppColors.correct;
    if (index == selectedIndex && selectedIndex != correctIndex) return AppColors.error;
    return AppColors.textTertiary;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _getColor(),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _getBorderColor(), width: 1.5),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: _getTextColor(),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (correctIndex != null && index == correctIndex)
              const Icon(Icons.check_circle_rounded, color: AppColors.correct, size: 20),
            if (correctIndex != null && index == selectedIndex && selectedIndex != correctIndex)
              const Icon(Icons.cancel_rounded, color: AppColors.error, size: 20),
          ],
        ),
      ),
    )
        .animate(key: ValueKey('$questionKey-$index'), delay: animDelay)
        .fadeIn(duration: 300.ms)
        .slideX(begin: 0.05, duration: 300.ms);
  }
}

// ---------------------------------------------------------------------------
// ResultScreen
// ---------------------------------------------------------------------------

class ResultScreen extends ConsumerWidget {
  const ResultScreen({
    super.key,
    required this.score,
    required this.total,
    required this.xpEarned,
    required this.categoryId,
  });

  final int score;
  final int total;
  final int xpEarned;
  final String categoryId;

  String _getTitle() {
    final ratio = score / total;
    if (ratio >= 0.9) return AppStrings.greatJob;
    if (ratio >= 0.6) return AppStrings.goodJob;
    return AppStrings.keepTrying;
  }

  Color _getScoreColor() {
    final ratio = score / total;
    if (ratio >= 0.9) return AppColors.correct;
    if (ratio >= 0.6) return AppColors.secondary;
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Score circle
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _getScoreColor().withOpacity(0.12),
                  border: Border.all(color: _getScoreColor(), width: 3),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$score/$total',
                      style: TextStyle(
                        color: _getScoreColor(),
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      AppStrings.correctAnswers,
                      style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .scale(begin: const Offset(0.7, 0.7), duration: 600.ms, curve: Curves.easeOutBack),
              const SizedBox(height: 32),
              Text(
                _getTitle(),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                textAlign: TextAlign.center,
              ).animate(delay: 200.ms).fadeIn(duration: 400.ms),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.secondary.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.bolt_rounded, color: AppColors.secondary, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      '+$xpEarned ${AppStrings.xpEarnedLabel}',
                      style: const TextStyle(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ).animate(delay: 350.ms).fadeIn(duration: 400.ms),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  onPressed: () => context.go('/challenge'),
                  child: const Text(
                    AppStrings.playAgain,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                ),
              ).animate(delay: 500.ms).fadeIn(duration: 400.ms).slideY(begin: 0.2, duration: 400.ms),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textPrimary,
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () => context.go('/home'),
                  child: const Text(
                    AppStrings.goHome,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
              ).animate(delay: 600.ms).fadeIn(duration: 400.ms),
            ],
          ),
        ),
      ),
    );
  }
}
