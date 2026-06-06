class Question {
  final String id;
  final String categoryId;
  final String type; // 'multiple_choice' or 'true_false'
  final String text;
  final List<String> options;
  final String correctAnswer;
  final String explanation;
  final int difficulty; // 1=easy, 2=medium, 3=hard
  final int xpReward; // 10=easy, 25=medium, 50=hard

  const Question({
    required this.id,
    required this.categoryId,
    required this.type,
    required this.text,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    required this.difficulty,
    required this.xpReward,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'categoryId': categoryId,
        'type': type,
        'text': text,
        'options': options,
        'correctAnswer': correctAnswer,
        'explanation': explanation,
        'difficulty': difficulty,
        'xpReward': xpReward,
      };

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json['id'] as String,
        categoryId: json['categoryId'] as String,
        type: json['type'] as String,
        text: json['text'] as String,
        options: List<String>.from(json['options'] as List),
        correctAnswer: json['correctAnswer'] as String,
        explanation: json['explanation'] as String,
        difficulty: json['difficulty'] as int,
        xpReward: json['xpReward'] as int,
      );
}
