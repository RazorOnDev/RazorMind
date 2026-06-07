import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('Override sharedPreferencesProvider in main()'),
);

class UserProgress {
  final int totalXp;
  final int currentStreak;
  final int bestStreak;
  final int totalQuestionsAnswered;
  final int totalCorrectAnswers;
  final bool isOnboardingComplete;
  final String? lastPlayedDate;
  final Map<String, int> categoryXP;
  final Map<String, int> categoryCorrect;
  final Map<String, int> categoryAttempted;
  final List<String> activityDates;
  final List<String> selectedCategories;
  final List<String> completedChallengeIds;
  final int rankPoints;
  final int longestCorrectStreak;

  const UserProgress({
    this.totalXp = 0,
    this.currentStreak = 0,
    this.bestStreak = 0,
    this.totalQuestionsAnswered = 0,
    this.totalCorrectAnswers = 0,
    this.isOnboardingComplete = false,
    this.lastPlayedDate,
    this.categoryXP = const {},
    this.categoryCorrect = const {},
    this.categoryAttempted = const {},
    this.activityDates = const [],
    this.selectedCategories = const [],
    this.completedChallengeIds = const [],
    this.rankPoints = 0,
    this.longestCorrectStreak = 0,
  });

  double get correctRate {
    if (totalQuestionsAnswered == 0) return 0;
    return totalCorrectAnswers / totalQuestionsAnswered;
  }

  int get level {
    const thresholds = [
      0, 100, 250, 500, 900, 1400, 2100, 3000, 4200, 5700,
      7500, 9600, 12100, 15000, 18500, 22500, 27000, 32000, 38000, 45000,
    ];
    for (int i = thresholds.length - 1; i >= 0; i--) {
      if (totalXp >= thresholds[i]) return i + 1;
    }
    return 1;
  }

  double categoryAccuracy(String catId) {
    final attempted = categoryAttempted[catId] ?? 0;
    final correct = categoryCorrect[catId] ?? 0;
    if (attempted == 0) return 0.0;
    return correct / attempted;
  }

  UserProgress copyWith({
    int? totalXp,
    int? currentStreak,
    int? bestStreak,
    int? totalQuestionsAnswered,
    int? totalCorrectAnswers,
    bool? isOnboardingComplete,
    String? lastPlayedDate,
    Map<String, int>? categoryXP,
    Map<String, int>? categoryCorrect,
    Map<String, int>? categoryAttempted,
    List<String>? activityDates,
    List<String>? selectedCategories,
    List<String>? completedChallengeIds,
    int? rankPoints,
    int? longestCorrectStreak,
  }) {
    return UserProgress(
      totalXp: totalXp ?? this.totalXp,
      currentStreak: currentStreak ?? this.currentStreak,
      bestStreak: bestStreak ?? this.bestStreak,
      totalQuestionsAnswered: totalQuestionsAnswered ?? this.totalQuestionsAnswered,
      totalCorrectAnswers: totalCorrectAnswers ?? this.totalCorrectAnswers,
      isOnboardingComplete: isOnboardingComplete ?? this.isOnboardingComplete,
      lastPlayedDate: lastPlayedDate ?? this.lastPlayedDate,
      categoryXP: categoryXP ?? this.categoryXP,
      categoryCorrect: categoryCorrect ?? this.categoryCorrect,
      categoryAttempted: categoryAttempted ?? this.categoryAttempted,
      activityDates: activityDates ?? this.activityDates,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      completedChallengeIds: completedChallengeIds ?? this.completedChallengeIds,
      rankPoints: rankPoints ?? this.rankPoints,
      longestCorrectStreak: longestCorrectStreak ?? this.longestCorrectStreak,
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
        'categoryXP': categoryXP,
        'categoryCorrect': categoryCorrect,
        'categoryAttempted': categoryAttempted,
        'activityDates': activityDates,
        'selectedCategories': selectedCategories,
        'completedChallengeIds': completedChallengeIds,
        'rankPoints': rankPoints,
        'longestCorrectStreak': longestCorrectStreak,
      };

  factory UserProgress.fromJson(Map<String, dynamic> json) => UserProgress(
        totalXp: (json['totalXp'] as int?) ?? 0,
        currentStreak: (json['currentStreak'] as int?) ?? 0,
        bestStreak: (json['bestStreak'] as int?) ?? 0,
        totalQuestionsAnswered: (json['totalQuestionsAnswered'] as int?) ?? 0,
        totalCorrectAnswers: (json['totalCorrectAnswers'] as int?) ?? 0,
        isOnboardingComplete: (json['isOnboardingComplete'] as bool?) ?? false,
        lastPlayedDate: json['lastPlayedDate'] as String?,
        categoryXP: _parseIntMap(json['categoryXP']),
        categoryCorrect: _parseIntMap(json['categoryCorrect']),
        categoryAttempted: _parseIntMap(json['categoryAttempted']),
        activityDates: _parseStringList(json['activityDates']),
        selectedCategories: _parseStringList(json['selectedCategories']),
        completedChallengeIds: _parseStringList(json['completedChallengeIds']),
        rankPoints: (json['rankPoints'] as int?) ?? 0,
        longestCorrectStreak: (json['longestCorrectStreak'] as int?) ?? 0,
      );

  static Map<String, int> _parseIntMap(dynamic raw) {
    if (raw == null) return const {};
    if (raw is Map) {
      return Map<String, int>.fromEntries(
        raw.entries.map((e) => MapEntry(e.key.toString(), (e.value as num?)?.toInt() ?? 0)),
      );
    }
    return const {};
  }

  static List<String> _parseStringList(dynamic raw) {
    if (raw == null) return const [];
    if (raw is List) return List<String>.from(raw);
    return const [];
  }
}

class ProgressNotifier extends Notifier<UserProgress> {
  static const _prefsKey = 'user_progress_v2';
  static const _legacyKey = 'user_progress';

  SharedPreferences get _prefs => ref.read(sharedPreferencesProvider);

  @override
  UserProgress build() {
    final raw = _prefs.getString(_prefsKey);
    if (raw == null) {
      final legacyRaw = _prefs.getString(_legacyKey);
      if (legacyRaw != null) {
        try {
          return UserProgress.fromJson(jsonDecode(legacyRaw) as Map<String, dynamic>);
        } catch (_) {}
      }
      return const UserProgress();
    }
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
    String categoryId = 'general',
    int rankPointsEarned = 0,
    int longestStreakInSession = 0,
  }) async {
    final today = _todayString();
    final wasPlayedToday = state.lastPlayedDate == today;

    int newStreak = state.currentStreak;
    if (!wasPlayedToday) {
      final yesterday = _yesterdayString();
      newStreak = state.lastPlayedDate == yesterday ? state.currentStreak + 1 : 1;
    }

    final newBest = newStreak > state.bestStreak ? newStreak : state.bestStreak;

    final newCatXP = Map<String, int>.from(state.categoryXP);
    final newCatCorrect = Map<String, int>.from(state.categoryCorrect);
    final newCatAttempted = Map<String, int>.from(state.categoryAttempted);
    if (categoryId != 'general') {
      newCatXP[categoryId] = (newCatXP[categoryId] ?? 0) + xpEarned;
      newCatCorrect[categoryId] = (newCatCorrect[categoryId] ?? 0) + correctAnswers;
      newCatAttempted[categoryId] = (newCatAttempted[categoryId] ?? 0) + questionsAnswered;
    }

    final newActivityDates = List<String>.from(state.activityDates);
    if (!newActivityDates.contains(today)) newActivityDates.add(today);

    final newLongestStreak = longestStreakInSession > state.longestCorrectStreak
        ? longestStreakInSession
        : state.longestCorrectStreak;

    await _save(
      state.copyWith(
        totalXp: state.totalXp + xpEarned,
        currentStreak: newStreak,
        bestStreak: newBest,
        totalQuestionsAnswered: state.totalQuestionsAnswered + questionsAnswered,
        totalCorrectAnswers: state.totalCorrectAnswers + correctAnswers,
        lastPlayedDate: today,
        categoryXP: newCatXP,
        categoryCorrect: newCatCorrect,
        categoryAttempted: newCatAttempted,
        activityDates: newActivityDates,
        rankPoints: state.rankPoints + rankPointsEarned,
        longestCorrectStreak: newLongestStreak,
      ),
    );
  }

  Future<void> resetProgress() async {
    await _prefs.remove(_prefsKey);
    state = const UserProgress(isOnboardingComplete: true);
  }

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

final progressProvider = NotifierProvider<ProgressNotifier, UserProgress>(
  ProgressNotifier.new,
);
