import 'package:flutter/material.dart';
import '../../domain/habit_type.dart';

abstract class AddHabitEvent {
  const AddHabitEvent();
}

class LoadHabitTypes extends AddHabitEvent {
  const LoadHabitTypes();
}

class SelectHabitType extends AddHabitEvent {
  final HabitType habitType;
  const SelectHabitType(this.habitType);
}

class SelectFromDate extends AddHabitEvent {
  final DateTime date;
  const SelectFromDate(this.date);
}

class SelectToDate extends AddHabitEvent {
  final DateTime date;
  const SelectToDate(this.date);
}

class SaveHabit extends AddHabitEvent {
  final HabitType habitType;
  final DateTime from;
  final DateTime to;
  final VoidCallback onSuccess;
  final void Function(String) onError;

  SaveHabit(this.habitType, this.from, this.to, {required this.onSuccess, required this.onError});
}
