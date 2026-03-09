import 'package:habittracker/core/data/repositories/domain/habit.dart';
import 'package:habittracker/core/data/repositories/habit_repository.dart';

class GetHabitNameUseCase {
  final HabitRepository _repository;

  GetHabitNameUseCase(this._repository);

  Future<Habit?> call(int habitId) => _repository.getById(habitId);
}