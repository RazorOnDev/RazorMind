import 'package:razor_mind/data/models/challenge_mode.dart';
import 'package:razor_mind/data/models/question.dart';

class QuestionService {
  // ---------------------------------------------------------------------------
  // QUESTION BANK — 193 questions across 7 categories
  // ---------------------------------------------------------------------------

  static const List<Question> _allQuestions = [
    // =========================================================================
    // HISTORIA — 16 questions
    // =========================================================================

    Question(
      id: 'hist_001',
      categoryId: 'history',
      type: 'multiple_choice',
      text: '¿En qué año llegó Cristóbal Colón a América?',
      options: ['1488', '1492', '1502', '1510'],
      correctAnswer: '1492',
      explanation:
          'Cristóbal Colón llegó a América el 12 de octubre de 1492, cuando divisó la isla de Guanahaní en el Caribe.',
      difficulty: 1,
      xpReward: 10,
    ),
PLACEHOLDER_MARKER_FOR_BUILD
  ];

  // ---------------------------------------------------------------------------
  // Public API
  // ---------------------------------------------------------------------------

  List<Question> getAll() => List.unmodifiable(_allQuestions);
}
