import 'dart:async';
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
import 'package:razor_mind/data/models/challenge_mode.dart';
import 'package:razor_mind/data/models/question.dart';
import 'package:razor_mind/data/providers/progress_provider.dart';
import 'package:razor_mind/data/providers/question_provider.dart';

// ---------------------------------------------------------------------------
// Adapted question view model
// ---------------------------------------------------------------------------

class _Q {
  final String id;
  final String text;
  final String categoryId;
  final String explanation;
  final List<String> options;
  final int correctIndex;
  final int xpReward;
  final int difficulty;
  final bool isTrueFalse;

  const _Q({
    required this.id,
    required this.text,
    required this.categoryId,
    required this.explanation,
    required this.options,
    required this.correctIndex,
    required this.xpReward,
    required this.difficulty,
    required this.isTrueFalse,
  });

  factory _Q.fromQuestion(Question q) {
    final idx = q.options.indexOf(q.correctAnswer);
    return _Q(
      id: q.id,
      text: q.text,
      categoryId: q.categoryId,
      explanation: q.explanation,
      options: q.options,
      correctIndex: idx >= 0 ? idx : 0,
      xpReward: q.xpReward,
      difficulty: q.difficulty,
      isTrueFalse: q.type == 'true_false',
    );
  }
}

// ---------------------------------------------------------------------------
// ChallengeScreen
// ---------------------------------------------------------------------------

class ChallengeScreen extends ConsumerStatefulWidget {
  final ChallengeMode mode;
  final String? categoryId;

  const ChallengeScreen({
    super.key,
    this.mode = ChallengeMode.daily,
    this.categoryId,
  });

  @override
  ConsumerState<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends ConsumerState<ChallengeScreen>
    with TickerProviderStateMixin {
  // ---------------------------------------------------------------------------
  // Data
  // ---------------------------------------------------------------------------
  late List<_Q> _questions;
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedAnswer;
  bool _answered = false;
  int _xpEarned = 0;
  int _consecutiveCorrect = 0;
  int _maxConsecutive = 0;

  // Survival
  int _hearts = 3;
  bool _gameOver = false;

  // Speed mode
  late AnimationController _timerController;
  int _secondsLeft = 15;
  Timer? _countdownTimer;

  // Question slide animation
  late AnimationController _slideController;
  late Animation<Offset> _slideIn;

  // Feedback bar
  late AnimationController _feedbackController;
  bool _showFeedback = false;
  bool _feedbackIsCorrect = false;

  // Combo banner
  late AnimationController _comboController;
  bool _showCombo = false;
  String _comboMessage = '';
  int _comboBonus = 0;

  // XP flash
  late AnimationController _xpFlashController;

  // Shake for wrong answer
  late AnimationController _shakeController;
  int? _wrongOptionIndex;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
    _initAnimations();
    if (widget.mode == ChallengeMode.speed && _questions.isNotEmpty) {
      _startSpeedTimer();
    }
  }

  void _loadQuestions() {
    final service = ref.read(questionServiceProvider);
    final prefs = ref.read(progressProvider);
    final raw = service.getForMode(
      widget.mode,
      prefs.selectedCategories,
      categoryId: widget.categoryId,
    );
    _questions = raw.map(_Q.fromQuestion).toList();
    if (_questions.isEmpty) {
      _questions = service.getAll().take(10).map(_Q.fromQuestion).toList();
    }
  }

  void _initAnimations() {
    _timerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    );

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _slideIn = Tween<Offset>(begin: const Offset(1.0, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));
    _slideController.forward();

    _feedbackController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _comboController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _xpFlashController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
  }

  // ---------------------------------------------------------------------------
  // Speed timer
  // ---------------------------------------------------------------------------

  void _startSpeedTimer() {
    _timerController.forward(from: 0);
    _secondsLeft = 15;
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      setState(() => _secondsLeft--);
      if (_secondsLeft <= 0) {
        t.cancel();
        if (!_answered) _onTimerExpired();
      }
    });
  }

  void _stopSpeedTimer() {
    _countdownTimer?.cancel();
    _timerController.stop();
  }

  void _onTimerExpired() {
    if (_answered) return;
    final wrongIndex = (_current.correctIndex + 1) % _current.options.length;
    _selectAnswer(wrongIndex, fromTimer: true);
  }

  void _resetSpeedTimer() {
    _timerController.forward(from: 0);
    _secondsLeft = 15;
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      setState(() => _secondsLeft--);
      if (_secondsLeft <= 0) {
        t.cancel();
        if (!_answered) _onTimerExpired();
      }
    });
  }

  // ---------------------------------------------------------------------------
  // Answer logic
  // ---------------------------------------------------------------------------

  void _selectAnswer(int index, {bool fromTimer = false}) {
    if (_answered) return;
    if (widget.mode == ChallengeMode.speed) _stopSpeedTimer();

    final isCorrect = index == _current.correctIndex;
    final speedBonus = widget.mode == ChallengeMode.speed && !fromTimer && _secondsLeft >= 8;
    final gained = _calculateXP(_current, isCorrect, speedBonus);

    if (isCorrect) {
      HapticFeedback.lightImpact();
      _consecutiveCorrect++;
      if (_consecutiveCorrect > _maxConsecutive) _maxConsecutive = _consecutiveCorrect;
    } else {
      HapticFeedback.mediumImpact();
      _consecutiveCorrect = 0;
      _wrongOptionIndex = index;
      _shakeController.forward(from: 0);
      if (widget.mode == ChallengeMode.survival) {
        setState(() => _hearts = (_hearts - 1).clamp(0, 3));
      }
    }

    setState(() {
      _selectedAnswer = index;
      _answered = true;
      if (isCorrect) {
        _score++;
        _xpEarned += gained;
      }
      _feedbackIsCorrect = isCorrect;
      _showFeedback = true;
    });

    _feedbackController.forward(from: 0);
    if (isCorrect) _xpFlashController.forward(from: 0);

    // Show combo banner
    if (_consecutiveCorrect >= 3) {
      Future.delayed(const Duration(milliseconds: 200), () {
        if (!mounted) return;
        setState(() {
          _showCombo = true;
          if (_consecutiveCorrect >= 5) {
            _comboMessage = '🔥🔥 En Racha!';
            _comboBonus = 10;
          } else {
            _comboMessage = '🔥 Combo x$_consecutiveCorrect!';
            _comboBonus = 8;
          }
        });
        _comboController.forward(from: 0);
        Future.delayed(const Duration(milliseconds: 2000), () {
          if (!mounted) return;
          _comboController.reverse();
          setState(() => _showCombo = false);
        });
      });
    }

    // Survival game-over check
    if (widget.mode == ChallengeMode.survival && _hearts <= 0) {
      Future.delayed(const Duration(milliseconds: 1200), () {
        if (!mounted) return;
        setState(() => _gameOver = true);
      });
    }
  }

  int _calculateXP(_Q question, bool isCorrect, bool speedBonus) {
    if (!isCorrect) return 0;
    int xp = question.xpReward;
    if (_consecutiveCorrect >= 5) {
      xp += 15;
    } else if (_consecutiveCorrect >= 3) {
      xp += 8;
    }
    if (speedBonus && widget.mode == ChallengeMode.speed) xp += 5;
    return xp;
  }

  void _next() {
    final isLastQuestion = _currentIndex >= _questions.length - 1;
    if (isLastQuestion) {
      _finishChallenge();
      return;
    }

    _feedbackController.reverse();
    Future.delayed(const Duration(milliseconds: 150), () {
      if (!mounted) return;
      setState(() {
        _currentIndex++;
        _selectedAnswer = null;
        _answered = false;
        _showFeedback = false;
        _wrongOptionIndex = null;
      });
      _slideController.forward(from: 0);
      if (widget.mode == ChallengeMode.speed) _resetSpeedTimer();
    });
  }

  void _finishChallenge() {
    _stopSpeedTimer();
    final answeredCount = _currentIndex + 1;
    final rankPoints = widget.mode == ChallengeMode.speed
        ? RankUtils.calculateRankPoints(
            correctAnswers: _score,
            totalQuestions: answeredCount,
            speedBonus: true,
          )
        : 0;

    ref.read(progressProvider.notifier).recordSession(
          xpEarned: _xpEarned,
          questionsAnswered: answeredCount,
          correctAnswers: _score,
          categoryId: widget.categoryId ?? 'general',
          rankPointsEarned: rankPoints,
          longestStreakInSession: _maxConsecutive,
        );

    context.go(
      '/challenge/result'
      '?score=$_score'
      '&total=$answeredCount'
      '&xpEarned=$_xpEarned'
      '&categoryId=${widget.categoryId ?? "general"}'
      '&mode=${widget.mode.name}'
      '&rankPoints=$rankPoints',
    );
  }

  _Q get _current => _questions[_currentIndex];

  @override
  void dispose() {
    _timerController.dispose();
    _slideController.dispose();
    _feedbackController.dispose();
    _comboController.dispose();
    _xpFlashController.dispose();
    _shakeController.dispose();
    _countdownTimer?.cancel();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'No hay preguntas disponibles',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go('/home'),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                child: const Text('Volver al inicio'),
              ),
            ],
          ),
        ),
      );
    }

    if (_gameOver) return _buildGameOver();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _buildTopBar(),
                _buildProgressBar(),
                Expanded(
                  child: SlideTransition(
                    position: _slideIn,
                    child: _buildQuestionArea(),
                  ),
                ),
                _buildOptionsArea(),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  child: _showFeedback ? _buildFeedbackBar() : const SizedBox(height: 0),
                ),
              ],
            ),
            if (_showCombo) _buildComboBanner(),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Top bar
  // ---------------------------------------------------------------------------

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              _stopSpeedTimer();
              context.go('/home');
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border),
              ),
              child: const Icon(Icons.close_rounded, color: AppColors.textSecondary, size: 18),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: _buildProgressIndicator()),
          const SizedBox(width: 12),
          _buildRightBadge(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    if (widget.mode == ChallengeMode.survival) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (i) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Text(
              i < _hearts ? '❤️' : '🖤',
              style: const TextStyle(fontSize: 20),
            ),
          );
        }),
      );
    }
    return Text(
      '${_currentIndex + 1} / ${_questions.length}',
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w600,
        fontSize: 15,
      ),
    );
  }

  Widget _buildRightBadge() {
    if (widget.mode == ChallengeMode.speed) {
      return AnimatedBuilder(
        animation: _timerController,
        builder: (_, __) {
          final frac = _timerController.isAnimating
              ? (1 - _timerController.value).clamp(0.0, 1.0)
              : 1.0;
          final color = _secondsLeft <= 5
              ? AppColors.error
              : _secondsLeft <= 10
                  ? AppColors.secondary
                  : AppColors.primary;
          return SizedBox(
            width: 40,
            height: 40,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: frac,
                  strokeWidth: 3,
                  backgroundColor: AppColors.border,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
                Text(
                  '$_secondsLeft',
                  style: TextStyle(
                    color: color,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return AnimatedBuilder(
      animation: _xpFlashController,
      builder: (_, __) {
        final scale = 1.0 +
            (_xpFlashController.value *
                0.15 *
                math.sin(_xpFlashController.value * math.pi));
        return Transform.scale(
          scale: scale,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.secondary.withOpacity(0.4)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.bolt_rounded, color: AppColors.secondary, size: 14),
                Text(
                  '$_xpEarned',
                  style: const TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Progress bar
  // ---------------------------------------------------------------------------

  Widget _buildProgressBar() {
    double progress;
    if (widget.mode == ChallengeMode.survival) {
      progress = _score / math.max(_currentIndex + 1, 1);
    } else {
      progress = (_currentIndex + 1) / _questions.length;
    }
    return LinearProgressIndicator(
      value: progress.clamp(0.0, 1.0),
      backgroundColor: AppColors.border,
      valueColor: AlwaysStoppedAnimation<Color>(
        widget.mode == ChallengeMode.survival ? AppColors.error : AppColors.primary,
      ),
      minHeight: 4,
    );
  }

  // ---------------------------------------------------------------------------
  // Question area
  // ---------------------------------------------------------------------------

  Widget _buildQuestionArea() {
    final cat = AppCategories.getById(_current.categoryId);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: cat.color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: cat.color.withOpacity(0.4)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(cat.emoji, style: const TextStyle(fontSize: 13)),
                    const SizedBox(width: 5),
                    Text(
                      cat.name,
                      style: TextStyle(
                        color: cat.color,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Row(
                children: List.generate(3, (i) {
                  final filled = i < _current.difficulty;
                  return Padding(
                    padding: const EdgeInsets.only(right: 3),
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: filled
                            ? _difficultyColor(_current.difficulty)
                            : AppColors.border,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            _current.text,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 19,
              fontWeight: FontWeight.w700,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Color _difficultyColor(int d) {
    if (d == 1) return AppColors.correct;
    if (d == 2) return AppColors.secondary;
    return AppColors.error;
  }

  // ---------------------------------------------------------------------------
  // Options area
  // ---------------------------------------------------------------------------

  Widget _buildOptionsArea() {
    if (_current.isTrueFalse) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
        child: Row(
          children: [
            Expanded(
              child: _OptionCard(
                label: '✓ Verdadero',
                index: 0,
                selectedIndex: _selectedAnswer,
                correctIndex: _answered ? _current.correctIndex : null,
                wrongOptionIndex: _wrongOptionIndex,
                shakeController: _shakeController,
                onTap: () => _selectAnswer(0),
                isTrueFalse: true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _OptionCard(
                label: '✗ Falso',
                index: 1,
                selectedIndex: _selectedAnswer,
                correctIndex: _answered ? _current.correctIndex : null,
                wrongOptionIndex: _wrongOptionIndex,
                shakeController: _shakeController,
                onTap: () => _selectAnswer(1),
                isTrueFalse: true,
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Column(
        children: List.generate(_current.options.length, (i) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _OptionCard(
              label: _current.options[i],
              index: i,
              selectedIndex: _selectedAnswer,
              correctIndex: _answered ? _current.correctIndex : null,
              wrongOptionIndex: _wrongOptionIndex,
              shakeController: _shakeController,
              onTap: () => _selectAnswer(i),
              delay: Duration(milliseconds: i * 50),
              questionKey: _currentIndex,
            ),
          );
        }),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Feedback bar
  // ---------------------------------------------------------------------------

  Widget _buildFeedbackBar() {
    final isLast = _currentIndex >= _questions.length - 1;
    final buttonLabel = isLast ? 'Ver resultados' : 'Continuar';

    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
          .animate(CurvedAnimation(parent: _feedbackController, curve: Curves.easeOut)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        decoration: BoxDecoration(
          color: _feedbackIsCorrect
              ? AppColors.correct.withOpacity(0.1)
              : AppColors.error.withOpacity(0.08),
          border: Border(
            top: BorderSide(
              color: _feedbackIsCorrect ? AppColors.correct : AppColors.error,
              width: 1.5,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  _feedbackIsCorrect
                      ? Icons.check_circle_rounded
                      : Icons.cancel_rounded,
                  color: _feedbackIsCorrect ? AppColors.correct : AppColors.error,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  _feedbackIsCorrect ? '¡Correcto!' : 'Incorrecto',
                  style: TextStyle(
                    color: _feedbackIsCorrect ? AppColors.correct : AppColors.error,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                if (_feedbackIsCorrect)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.bolt_rounded, color: AppColors.secondary, size: 14),
                        Text(
                          '+${_calculateXP(_current, true, false)} XP',
                          style: const TextStyle(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            if (!_feedbackIsCorrect) ...[
              const SizedBox(height: 4),
              Text(
                'Correcta: ${_current.options[_current.correctIndex]}',
                style: const TextStyle(
                  color: AppColors.correct,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            const SizedBox(height: 6),
            Text(
              _current.explanation,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
                height: 1.4,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _feedbackIsCorrect ? AppColors.correct : AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: _next,
                child: Text(
                  buttonLabel,
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Combo banner
  // ---------------------------------------------------------------------------

  Widget _buildComboBanner() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
            .animate(
                CurvedAnimation(parent: _comboController, curve: Curves.easeOut)),
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 80, 16, 0),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.secondary, Color(0xFFD97706)],
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: AppColors.secondary.withOpacity(0.4),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _comboMessage,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
              if (_comboBonus > 0) ...[
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '+$_comboBonus XP',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Survival game over
  // ---------------------------------------------------------------------------

  Widget _buildGameOver() {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('💀', style: TextStyle(fontSize: 72))
                    .animate()
                    .scale(
                        begin: const Offset(0, 0),
                        duration: 600.ms,
                        curve: Curves.easeOutBack),
                const SizedBox(height: 24),
                const Text(
                  'Game Over',
                  style: TextStyle(
                    color: AppColors.error,
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                  ),
                ).animate(delay: 200.ms).fadeIn(duration: 400.ms),
                const SizedBox(height: 16),
                Text(
                  'Respondiste $_currentIndex preguntas',
                  style: const TextStyle(
                      color: AppColors.textSecondary, fontSize: 16),
                ).animate(delay: 400.ms).fadeIn(duration: 400.ms),
                const SizedBox(height: 8),
                Text(
                  '$_score correctas',
                  style: const TextStyle(
                    color: AppColors.correct,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ).animate(delay: 500.ms).fadeIn(duration: 400.ms),
                const SizedBox(height: 48),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: _finishChallenge,
                    child: const Text(
                      'Ver resultados',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                  ),
                )
                    .animate(delay: 700.ms)
                    .fadeIn(duration: 400.ms)
                    .slideY(begin: 0.2, duration: 400.ms),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textSecondary,
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () => context.go('/home'),
                    child: const Text(
                      'Volver al inicio',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                  ),
                ).animate(delay: 800.ms).fadeIn(duration: 400.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Option card widget
// ---------------------------------------------------------------------------

class _OptionCard extends StatelessWidget {
  final String label;
  final int index;
  final int? selectedIndex;
  final int? correctIndex;
  final int? wrongOptionIndex;
  final AnimationController shakeController;
  final VoidCallback onTap;
  final bool isTrueFalse;
  final Duration delay;
  final int? questionKey;

  const _OptionCard({
    required this.label,
    required this.index,
    required this.selectedIndex,
    required this.correctIndex,
    required this.wrongOptionIndex,
    required this.shakeController,
    required this.onTap,
    this.isTrueFalse = false,
    this.delay = Duration.zero,
    this.questionKey,
  });

  Color _bgColor() {
    if (correctIndex == null) return AppColors.card;
    if (index == correctIndex) return AppColors.correct.withOpacity(0.15);
    if (index == selectedIndex && selectedIndex != correctIndex) {
      return AppColors.error.withOpacity(0.12);
    }
    return AppColors.card;
  }

  Color _borderColor() {
    if (correctIndex == null) {
      return index == selectedIndex ? AppColors.primary : AppColors.border;
    }
    if (index == correctIndex) return AppColors.correct;
    if (index == selectedIndex && selectedIndex != correctIndex) return AppColors.error;
    return AppColors.border;
  }

  Color _textColor() {
    if (correctIndex == null) return AppColors.textPrimary;
    if (index == correctIndex) return AppColors.correct;
    if (index == selectedIndex && selectedIndex != correctIndex) return AppColors.error;
    return AppColors.textTertiary;
  }

  double _opacity() {
    if (correctIndex == null) return 1.0;
    if (index == correctIndex) return 1.0;
    if (index == selectedIndex) return 1.0;
    return 0.45;
  }

  @override
  Widget build(BuildContext context) {
    final isWrong = index == wrongOptionIndex;

    Widget card = GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: _opacity(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: isTrueFalse ? 20 : 14,
          ),
          decoration: BoxDecoration(
            color: _bgColor(),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _borderColor(), width: 1.5),
            boxShadow: correctIndex != null && index == correctIndex
                ? [
                    BoxShadow(
                      color: AppColors.correct.withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment:
                isTrueFalse ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              if (!isTrueFalse) ...[
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: _borderColor().withOpacity(0.15),
                    shape: BoxShape.circle,
                    border: Border.all(color: _borderColor(), width: 1),
                  ),
                  child: Center(
                    child: Text(
                      String.fromCharCode(65 + index),
                      style: TextStyle(
                        color: _borderColor(),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    color: _textColor(),
                    fontSize: isTrueFalse ? 16 : 15,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign:
                      isTrueFalse ? TextAlign.center : TextAlign.start,
                ),
              ),
              if (correctIndex != null && index == correctIndex) ...[
                const SizedBox(width: 8),
                const Icon(Icons.check_circle_rounded,
                    color: AppColors.correct, size: 20),
              ],
              if (correctIndex != null &&
                  index == selectedIndex &&
                  selectedIndex != correctIndex) ...[
                const SizedBox(width: 8),
                const Icon(Icons.cancel_rounded, color: AppColors.error, size: 20),
              ],
            ],
          ),
        ),
      ),
    );

    if (isWrong) {
      card = AnimatedBuilder(
        animation: shakeController,
        builder: (_, child) {
          final shake = math.sin(shakeController.value * math.pi * 6) *
              8 *
              (1 - shakeController.value);
          return Transform.translate(offset: Offset(shake, 0), child: child);
        },
        child: card,
      );
    }

    if (questionKey != null) {
      return card
          .animate(key: ValueKey('$questionKey-$index'), delay: delay)
          .fadeIn(duration: 300.ms)
          .slideX(begin: 0.04, duration: 300.ms);
    }
    return card;
  }
}

// ---------------------------------------------------------------------------
// ResultScreen (route: /challenge/result)
// ---------------------------------------------------------------------------

class ResultScreen extends ConsumerStatefulWidget {
  final int score;
  final int total;
  final int xpEarned;
  final int rankPointsEarned;
  final String categoryId;
  final String mode;

  const ResultScreen({
    super.key,
    required this.score,
    required this.total,
    required this.xpEarned,
    required this.categoryId,
    this.rankPointsEarned = 0,
    this.mode = 'daily',
  });

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen>
    with TickerProviderStateMixin {
  late AnimationController _circleController;
  late Animation<double> _circleAnim;
  bool _levelUp = false;
  int _newLevel = 1;
  String _newLevelTitle = '';

  @override
  void initState() {
    super.initState();
    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _circleAnim =
        CurvedAnimation(parent: _circleController, curve: Curves.easeOut);
    _circleController.forward();

    // Check level-up
    final progress = ref.read(progressProvider);
    final oldXp = (progress.totalXp - widget.xpEarned).clamp(0, 999999);
    final oldLevel = LevelUtils.getLevel(oldXp);
    final newLevel = LevelUtils.getLevel(progress.totalXp);
    if (newLevel > oldLevel) {
      _levelUp = true;
      _newLevel = newLevel;
      _newLevelTitle = LevelUtils.getLevelTitle(newLevel);
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (mounted) HapticFeedback.heavyImpact();
      });
    }

    // Perfect score haptic
    if (widget.score == widget.total && widget.total > 0) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) HapticFeedback.heavyImpact();
      });
    }
  }

  @override
  void dispose() {
    _circleController.dispose();
    super.dispose();
  }

  double get _ratio => widget.total > 0 ? widget.score / widget.total : 0;

  Color get _scoreColor {
    if (_ratio >= 0.7) return AppColors.correct;
    if (_ratio >= 0.5) return AppColors.secondary;
    return AppColors.error;
  }

  String get _performanceMessage {
    if (_ratio >= 0.9) return '¡PERFECTO!';
    if (_ratio >= 0.7) return '¡Excelente!';
    if (_ratio >= 0.5) return '¡Buen trabajo!';
    return 'Sigue practicando';
  }

  String get _performanceEmoji {
    if (_ratio >= 0.9) return '⭐';
    if (_ratio >= 0.7) return '🎉';
    if (_ratio >= 0.5) return '💪';
    return '📚';
  }

  @override
  Widget build(BuildContext context) {
    final progress = ref.watch(progressProvider);
    final streak = progress.currentStreak;
    final pct = widget.total > 0 ? ((_ratio) * 100).round() : 0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 140),
              child: Column(
                children: [
                  // Score circle
                  _buildScoreCircle(),
                  const SizedBox(height: 24),

                  // Performance message
                  Column(
                    children: [
                      Text(_performanceEmoji,
                          style: const TextStyle(fontSize: 40)),
                      const SizedBox(height: 8),
                      Text(
                        _performanceMessage,
                        style: TextStyle(
                          color: _ratio >= 0.9
                              ? AppColors.primaryLight
                              : AppColors.textPrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  )
                      .animate(delay: 500.ms)
                      .fadeIn(duration: 400.ms)
                      .slideY(begin: 0.1, duration: 400.ms),
                  const SizedBox(height: 24),

                  // XP card
                  _buildXpCard().animate(delay: 700.ms).fadeIn(duration: 400.ms),
                  const SizedBox(height: 20),

                  // Stats row
                  _buildStatsRow(streak, pct)
                      .animate(delay: 900.ms)
                      .fadeIn(duration: 400.ms),
                  const SizedBox(height: 20),

                  // Level up
                  if (_levelUp)
                    _buildLevelUpCard()
                        .animate(delay: 1100.ms)
                        .fadeIn(duration: 500.ms)
                        .slideY(
                            begin: 0.15,
                            duration: 500.ms,
                            curve: Curves.easeOutBack),
                ],
              ),
            ),

            // Pinned action buttons
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  border: Border(top: BorderSide(color: AppColors.border)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                        ),
                        onPressed: () => context.go('/home'),
                        child: const Text(
                          'Volver al inicio',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.textPrimary,
                          side: const BorderSide(color: AppColors.border),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                        ),
                        onPressed: () => context.go('/modes'),
                        child: const Text(
                          'Otro desafío',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              )
                  .animate(delay: 1000.ms)
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.2, duration: 400.ms),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreCircle() {
    return AnimatedBuilder(
      animation: _circleAnim,
      builder: (_, __) {
        final displayScore = (_circleAnim.value * widget.score).round();
        return SizedBox(
          width: 140,
          height: 140,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 140,
                height: 140,
                child: CircularProgressIndicator(
                  value: (_circleAnim.value * _ratio).clamp(0.0, 1.0),
                  strokeWidth: 8,
                  backgroundColor: AppColors.border,
                  valueColor: AlwaysStoppedAnimation<Color>(_scoreColor),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$displayScore/${widget.total}',
                    style: TextStyle(
                      color: _scoreColor,
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Text(
                    'correctas',
                    style: TextStyle(
                        color: AppColors.textSecondary, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .scale(
            begin: const Offset(0.7, 0.7),
            duration: 800.ms,
            curve: Curves.easeOutBack);
  }

  Widget _buildXpCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.secondary.withOpacity(0.25)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.bolt_rounded, color: AppColors.secondary, size: 28),
              const SizedBox(width: 6),
              Text(
                '+${widget.xpEarned} XP',
                style: const TextStyle(
                  color: AppColors.secondary,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          if (widget.rankPointsEarned > 0) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('🏆', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 6),
                Text(
                  '+${widget.rankPointsEarned} Puntos de Rango',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatsRow(int streak, int pct) {
    return Row(
      children: [
        _StatCard(
            label: 'Correctas',
            value: '${widget.score}/${widget.total}',
            color: AppColors.correct),
        const SizedBox(width: 10),
        _StatCard(label: 'Precisión', value: '$pct%', color: AppColors.primary),
        const SizedBox(width: 10),
        _StatCard(
          label: 'Racha',
          value: streak > 0 ? '🔥 $streak días' : '—',
          color: AppColors.secondary,
        ),
      ],
    );
  }

  Widget _buildLevelUpCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          const Text('🎉', style: TextStyle(fontSize: 32)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¡Subiste al Nivel $_newLevel!',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  _newLevelTitle,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.85), fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(color: AppColors.textTertiary, fontSize: 11),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
