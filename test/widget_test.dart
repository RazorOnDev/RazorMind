import 'package:flutter_test/flutter_test.dart';
import 'package:razor_mind/core/utils/level_utils.dart';

void main() {
  group('LevelUtils', () {
    test('level 1 starts at 0 XP', () {
      expect(LevelUtils.getLevel(0), 1);
      expect(LevelUtils.getLevel(99), 1);
    });

    test('level 2 starts at 100 XP', () {
      expect(LevelUtils.getLevel(100), 2);
      expect(LevelUtils.getLevel(249), 2);
    });

    test('level 3 starts at 250 XP', () {
      expect(LevelUtils.getLevel(250), 3);
    });

    test('returns correct level title', () {
      expect(LevelUtils.getLevelTitle(1), 'Aprendiz');
      expect(LevelUtils.getLevelTitle(10), 'Genio');
      expect(LevelUtils.getLevelTitle(20), 'RazorMind');
    });

    test('getLevelProgress is between 0 and 1', () {
      final progress = LevelUtils.getLevelProgress(150);
      expect(progress, greaterThanOrEqualTo(0.0));
      expect(progress, lessThanOrEqualTo(1.0));
    });

    test('calculateXpReward: 10 correct = 100 XP base', () {
      final xp = LevelUtils.calculateXpReward(
        correctAnswers: 10,
        totalQuestions: 10,
        isStreakActive: false,
      );
      // 10 * 10 base + 50 perfect bonus = 150
      expect(xp, 150);
    });

    test('calculateXpReward: streak adds 20% bonus', () {
      final xp = LevelUtils.calculateXpReward(
        correctAnswers: 5,
        totalQuestions: 10,
        isStreakActive: true,
      );
      // 5 * 10 = 50 base + (50 * 0.2) = 10 streak bonus = 60
      expect(xp, 60);
    });
  });
}
