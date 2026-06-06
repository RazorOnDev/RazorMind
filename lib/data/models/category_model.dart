import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String name;
  final String emoji;
  final String description;
  final int colorValue;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.emoji,
    required this.description,
    required this.colorValue,
  });

  Color get color => Color(colorValue);
}

abstract final class AppCategories {
  static const List<CategoryModel> all = [
    CategoryModel(
      id: 'history',
      name: 'Historia',
      emoji: '🏛️',
      description: 'Civilizaciones, guerras y personajes que moldearon el mundo',
      colorValue: 0xFFE07B54,
    ),
    CategoryModel(
      id: 'science',
      name: 'Ciencia',
      emoji: '🔬',
      description: 'Física, química, biología y los secretos del universo',
      colorValue: 0xFF3B82F6,
    ),
    CategoryModel(
      id: 'geography',
      name: 'Geografía',
      emoji: '🌍',
      description: 'Países, capitales, montañas y océanos del planeta',
      colorValue: 0xFF10B981,
    ),
    CategoryModel(
      id: 'art',
      name: 'Arte',
      emoji: '🎨',
      description: 'Pintores, escultores, música y movimientos artísticos',
      colorValue: 0xFFEC4899,
    ),
    CategoryModel(
      id: 'tech',
      name: 'Tecnología',
      emoji: '💻',
      description: 'Innovación, inventos y el mundo digital',
      colorValue: 0xFF6366F1,
    ),
    CategoryModel(
      id: 'philosophy',
      name: 'Filosofía',
      emoji: '🧠',
      description: 'Pensadores, escuelas filosóficas y grandes ideas',
      colorValue: 0xFF8B5CF6,
    ),
    CategoryModel(
      id: 'language',
      name: 'Lenguaje',
      emoji: '📚',
      description: 'Gramática, etimología y curiosidades del lenguaje',
      colorValue: 0xFFF59E0B,
    ),
  ];

  static CategoryModel getById(String id) =>
      all.firstWhere((c) => c.id == id, orElse: () => all.first);
}
