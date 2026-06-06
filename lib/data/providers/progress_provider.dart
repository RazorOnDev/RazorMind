import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provides the [SharedPreferences] instance injected at startup.
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('Override sharedPreferencesProvider in main()'),
);

/// Immutable snapshot of the user's learning progress.
class UserProgress {
  final int totalXp;
  final int currentStreak;
  final int bestStreak;
  final int totalQuestionsAnswered;
  final int totalCorrectAnswers;
  final bool isOnboardingComplete;
  final String? lastPlayedDate; // ISO-8601 date string yyyy-MM-dd

  const UserProgress({
    this.totalXp = 0,
    this.currentStreak = 0,
    this.bestStreak = 0,
    this.totalQuestionsAnswered = 0,
    this.totalCorrectAnswers = 0,
    this.isOnboardingComplete = false,
    this.lastPlayedDate,
  });

  double get correctRate {
    if (totalQuestionsAnswered == 0) return 0;
    return totalCorrectAnswers / totalQuestionsAnswered;
  }

  UserProgress copyWith({
    int? totalXp,
    int? currentStreak,
    int? bestStreak,
    int? totalQuestionsAnswered,
    int? totalCorrectAnswers,
    bool? isOnboardingComplete,
    String? lastPlayedDate,
  }) {
    return UserProgress(
      totalXp: totalXp ?? this.totalXp,
      currentStreak: currentStreak ?? this.currentStreak,
      bestStreak: bestStreak ?? this.bestStreak,
      totalQuestionsAnswered: totalQuestionsAnswered ?? this.totalQuestionsAnswered,
      totalCorrectAnswers: totalCorrectAnswers ?? this.totalCorrectAnswers,
      isOnboardingComplete: isOnboardingComplete ?? this.isOnboardingComplete,
      lastPlayedDate: lastPlayedDate ?? this.lastPlayedDate,
    );
  }

  Map<String, dynamic> toJson() => {
        'totalXp': totalXp,
        'currentStreak': currentStreak,
        'bestStreak': bestStreak,
        'totalQuestionsAnswered': totalQuestionsAnswered,
        'totalCorrectAnswers': totalCorrectAnswers,
        'isOnboardingComplete': isOnboardingComplete,
        'lastPlayedDate': lastPlayedDate,
      };

  factory UserProgress.fromJson(Map<String, dynamic> json) => UserProgress(
        totalXp: (json['totalXp'] as int?) ?? 0,
        currentStreak: (json['currentStreak'] as int?) ?? 0,
        bestStreak: (json['bestStreak'] as int?) ?? 0,
        totalQuestionsAnswered: (json['totalQuestionsAnswered'] as int?) ?? 0,
        totalCorrectAnswers: (json['totalCorrectAnswers'] as int?) ?? 0,
        isOnboardingComplete: (json['isOnboardingComplete'] as bool?) ?? false,
        lastPlayedDate: json['lastPlayedDate'] as String?,
      );
}

// ---------------------------------------------------------------------------
// Notifier
// ---------------------------------------------------------------------------

class ProgressNotifier extends Notifier<UserProgress> {
  static const _prefsKey = 'user_progress';

  SharedPreferences get _prefs => ref.read(sharedPreferencesProvider);

  @override
  UserProgress build() {
    final raw = _prefs.getString(_prefsKey);
    if (raw == null) return const UserProgress();
    try {
      return UserProgress.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return const UserProgress();
    }
  }

  Future<void> _save(UserProgress progress) async {
    state = progress;
    await _prefs.setString(_prefsKey, jsonEncode(progress.toJson()));
  }

  Future<void> completeOnboarding() async {
    await _save(state.copyWith(isOnboardingComplete: true));
  }

  Future<void> recordSession({
    required int xpEarned,
    required int questionsAnswered,
    required int correctAnswers,
  }) async {
    final today = _todayString();
    final wasPlayedToday = state.lastPlayedDate == today;

    int newStreak = state.currentStreak;
    if (!wasPlayedToday) {
      final yesterday = _yesterdayString();
      newStreak = state.lastPlayedDate == yesterday ? state.currentStreak + 1 : 1;
    }

    final newBest = newStreak > state.bestStreak ? newStreak : state.bestStreak;

    await _save(
      state.copyWith(
        totalXp: state.totalXp + xpEarned,
        currentStreak: newStreak,
        bestStreak: newBest,
        totalQuestionsAnswered: state.totalQuestionsAnswered + questionsAnswered,
        totalCorrectAnswers: state.totalCorrectAnswers + correctAnswers,
        lastPlayedDate: today,
      ),
    );
  }

  Future<void> resetProgress() async {
    await _prefs.remove(_prefsKey);
    state = const UserProgress(isOnboardingComplete: true);
  }

  // -------------------------------------------------------------------------
  // Helpers
  // -------------------------------------------------------------------------

  String _todayString() {
    final now = DateTime.now();
    return '${now.year}-${_pad(now.month)}-${_pad(now.day)}';
  }

  String _yesterdayString() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return '${yesterday.year}-${_pad(yesterday.month)}-${_pad(yesterday.day)}';
  }

  String _pad(int n) => n.toString().padLeft(2, '0');
}

// ---------------------------------------------------------------------------
// Provider
// ---------------------------------------------------------------------------

final progressProvider = NotifierProvider<ProgressNotifier, UserProgress>(
  ProgressNotifier.new,
);
