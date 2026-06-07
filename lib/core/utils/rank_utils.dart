import 'package:flutter/material.dart';

class RankUtils {
  static const List<int> thresholds = [0, 500, 1500, 3500, 7500, 15000, 30000];
  static const List<String> names = [
    'Bronce', 'Plata', 'Oro', 'Platino', 'Diamante', 'Maestro', 'RazorMind',
  ];
  static const List<String> emojis = ['🥉', '🥈', '🥇', '💎', '💠', '👑', '🧠'];
  static const List<String> descriptions = [
    'Aprendiz — Domina las bases',
    'En progreso — Conocimiento sólido',
    'Mente afilada — Superas a la mayoría',
    'Elite — Top 20% de jugadores',
    'Excepcional — Top 5%',
    'Genio — Entre los mejores',
    'Legendario — La élite absoluta',
  ];
  static const List<Color> colors = [
    Color(0xFFCD7F32), // bronze
    Color(0xFFB0B0C8), // silver
    Color(0xFFFFD700), // gold
    Color(0xFF00E5FF), // platinum
    Color(0xFF00BFFF), // diamond
    Color(0xFFB44EFF), // master
    Color(0xFF6366F1), // razormind
  ];

  static int getRankIndex(int rankPoints) {
    for (int i = thresholds.length - 1; i >= 0; i--) {
      if (rankPoints >= thresholds[i]) return i;
    }
    return 0;
  }

  static String getRankName(int rankPoints) => names[getRankIndex(rankPoints)];
  static String getRankEmoji(int rankPoints) => emojis[getRankIndex(rankPoints)];
  static Color getRankColor(int rankPoints) => colors[getRankIndex(rankPoints)];
  static String getRankDescription(int rankPoints) => descriptions[getRankIndex(rankPoints)];

  static int getNextRankThreshold(int rankPoints) {
    final idx = getRankIndex(rankPoints);
    if (idx >= thresholds.length - 1) return thresholds.last;
    return thresholds[idx + 1];
  }

  static String getNextRankName(int rankPoints) {
    final idx = getRankIndex(rankPoints);
    if (idx >= names.length - 1) return names.last;
    return names[idx + 1];
  }

  static double getRankProgress(int rankPoints) {
    final idx = getRankIndex(rankPoints);
    if (idx >= thresholds.length - 1) return 1.0;
    final current = thresholds[idx];
    final next = thresholds[idx + 1];
    return (rankPoints - current) / (next - current);
  }

  static int calculateRankPoints({
    required int correctAnswers,
    required int totalQuestions,
    bool speedBonus = false,
  }) {
    final base = correctAnswers * 30;
    final perfectBonus = correctAnswers == totalQuestions ? 100 : 0;
    final speedMult = speedBonus ? 50 : 0;
    return base + perfectBonus + speedMult;
  }

  const RankUtils._();
}
