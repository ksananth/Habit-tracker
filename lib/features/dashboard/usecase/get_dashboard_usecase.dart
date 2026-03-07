import 'package:habittracker/core/data/repositories/domain/habit.dart';

import '../../../core/data/repositories/habit_repository.dart';

class GetDashboardUseCase {

  final HabitRepository _repository;

  GetDashboardUseCase(this._repository);

  Future<List<Habit>?> call() => _repository.getAll();


}