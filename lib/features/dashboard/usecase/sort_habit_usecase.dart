import 'package:habittracker/features/dashboard/domain/sort_order.dart';

import '../../../core/data/repositories/domain/habit.dart';
import '../../../core/data/repositories/habit_repository.dart';

class SortHabitUseCase {
  final HabitRepository _repository;

  SortHabitUseCase(this._repository);

  Future<List<Habit>?> call(SortOrder order) async {
    final habits = await _repository.getAll();

    return switch (order) {
      SortOrder.createdDate =>
        habits..sort((a, b) => a.createdDate.compareTo(b.createdDate)),
      SortOrder.name => habits..sort((a, b) => b.name.compareTo(a.name)),
    };
  }
}
