import 'package:flutter/material.dart';

enum HabitType {
  exercise('Exercise', Icons.fitness_center),
  reading('Reading', Icons.menu_book),
  meditation('Meditation', Icons.self_improvement),
  journaling('Journaling', Icons.edit_note),
  hydration('Hydration', Icons.water_drop),
  sleep('Sleep', Icons.bedtime),
  healthyEating('Healthy Eating', Icons.restaurant),
  learning('Learning', Icons.school),
  walking('Walking', Icons.directions_walk),
  stretching('Stretching', Icons.accessibility_new);

  const HabitType(this.label, this.icon);

  final String label;
  final IconData icon;
}
