import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razor_mind/data/models/question.dart';
import 'package:razor_mind/data/services/question_service.dart';

// ---------------------------------------------------------------------------
// Service provider
// ---------------------------------------------------------------------------

/// Provides the [QuestionService] singleton (all questions are in-memory).
final questionServiceProvider = Provider<QuestionService>(
  (ref) => QuestionService(),
);

// ---------------------------------------------------------------------------
// Derived providers
// ---------------------------------------------------------------------------

/// Returns all questions in the bank.
final allQuestionsProvider = Provider<List<Question>>((ref) {
  return ref.watch(questionServiceProvider).getAll();
});

/// Returns questions filtered by category id.
///
/// Usage:
/// ```dart
/// final questions = ref.watch(questionsByCategoryProvider('history'));
/// ```
final questionsByCategoryProvider =
    Provider.family<List<Question>, String>((ref, categoryId) {
  return ref.watch(questionServiceProvider).getByCategory(categoryId);
});

/// Returns questions filtered by difficulty (1=easy, 2=medium, 3=hard).
final questionsByDifficultyProvider =
    Provider.family<List<Question>, int>((ref, difficulty) {
  return ref.watch(questionServiceProvider).getByDifficulty(difficulty);
});
