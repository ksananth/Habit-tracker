import 'package:habittracker/core/data/repositories/domain/habit.dart';

abstract class DashboardState {
  const DashboardState();
}

class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

class DashboardEmpty extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<Habit> habits;

  const DashboardLoaded(this.habits);
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError(this.message);
}
