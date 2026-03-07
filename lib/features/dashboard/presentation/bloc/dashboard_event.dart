abstract class DashboardEvent  {
  const DashboardEvent();
}

class LoadHabit extends DashboardEvent {}
class AddNewHabit extends DashboardEvent {}
class GotoHome extends DashboardEvent {}