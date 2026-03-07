import 'package:flutter/material.dart';
import 'package:habittracker/core/data/repositories/domain/habit.dart';
import 'package:habittracker/features/dashboard/presentation/widgets/habit_card.dart';

class HabitList extends StatelessWidget {
  final List<Habit> habits;

  const HabitList({super.key, required this.habits});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: habits.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) => HabitCard(habit: habits[index]),
    );
  }
}
