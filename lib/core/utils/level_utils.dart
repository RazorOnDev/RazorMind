class LevelUtils {
  static const List<int> _thresholds = [
    0, 100, 250, 500, 900, 1400, 2100, 3000, 4200, 5700,
    7500, 9600, 12100, 15000, 18500, 22500, 27000, 32000, 38000, 45000,
  ];

  static int getLevel(int xp) {
    for (int i = _thresholds.length - 1; i >= 0; i--) {
      if (xp >= _thresholds[i]) return i + 1;
    }
    return 1;
  }

  static int getXpForLevel(int level) {
    if (level <= 0) return 0;
    if (level > _thresholds.length) return _thresholds.last;
    return _thresholds[level - 1];
  }

  static int getXpForNextLevel(int level) {
    if (level >= _thresholds.length) return _thresholds.last;
    return _thresholds[level];
  }

  static double getLevelProgress(int xp) {
    final level = getLevel(xp);
    final currentLevelXp = getXpForLevel(level);
    final nextLevelXp = getXpForNextLevel(level);
    if (nextLevelXp == currentLevelXp) return 1.0;
    return (xp - currentLevelXp) / (nextLevelXp - currentLevelXp);
  }

  static String getLevelTitle(int level) {
    const titles = [
      'Aprendiz', 'Explorador', 'Curioso', 'Pensador', 'Analista',
      'Investigador', 'Erudito', 'Sabio', 'Maestro', 'Genio',
      'Leyenda', 'Visionario', 'Oracle', 'Iluminado', 'Inmortal',
      'Cósmico', 'Supremo', 'Omnisciente', 'Eterno', 'RazorMind',
    ];
    final idx = (level - 1).clamp(0, titles.length - 1);
    return titles[idx];
  }

  static int xpForCurrentLevel(int xp) => getXpForLevel(getLevel(xp));
  static int xpForNextLevel(int xp) => getXpForNextLevel(getLevel(xp));

  static int calculateXpReward({
    required int correctAnswers,
    required int totalQuestions,
    required bool isStreakActive,
  }) {
    final baseXp = correctAnswers * 10;
    final perfectBonus = correctAnswers == totalQuestions ? 50 : 0;
    final streakBonus = isStreakActive ? (baseXp * 0.2).round() : 0;
    return baseXp + perfectBonus + streakBonus;
  }
}
