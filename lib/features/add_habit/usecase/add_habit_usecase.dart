import 'package:habittracker/core/data/repositories/domain/habit.dart';
import 'package:habittracker/core/data/repositories/habit_repository.dart';

class AddHabitUseCase {
  final HabitRepository _repository;

  AddHabitUseCase(this._repository);

  Future<void> call({
    required String name,
    required DateTime startDate,
    DateTime? endDate,
  }) =>
      _repository.add(
        Habit(
          name: name,
          startDate: startDate,
          endDate: endDate,
          createdDate: DateTime.now(),
        ),
      );
}
