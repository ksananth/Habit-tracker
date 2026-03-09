import 'package:habittracker/features/dashboard/domain/sort_order.dart';

abstract class DashboardEvent  {
  const DashboardEvent();
}

class LoadHabit extends DashboardEvent {}
class AddNewHabit extends DashboardEvent {}
class GotoHome extends DashboardEvent {}

class SortHabits extends DashboardEvent {
  final SortOrder sortOrder;
  const SortHabits(this.sortOrder);
}