enum ChallengeMode { daily, speed, survival, marathon }

extension ChallengeModeX on ChallengeMode {
  String get displayName {
    switch (this) {
      case ChallengeMode.daily:
        return 'Desafío Diario';
      case ChallengeMode.speed:
        return 'Modo Velocidad';
      case ChallengeMode.survival:
        return 'Supervivencia';
      case ChallengeMode.marathon:
        return 'Maratón';
    }
  }

  String get emoji {
    switch (this) {
      case ChallengeMode.daily:
        return '🎯';
      case ChallengeMode.speed:
        return '⚡';
      case ChallengeMode.survival:
        return '❤️';
      case ChallengeMode.marathon:
        return '🏃';
    }
  }
}
