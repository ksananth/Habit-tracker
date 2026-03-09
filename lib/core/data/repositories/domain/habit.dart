class Habit {
  final int id;
  final String name;
  final DateTime createdDate;
  final DateTime startDate;
  final DateTime endDate;

  const Habit({
    this.id = 0,
    required this.name,
    required this.createdDate,
    required this.startDate,
    required this.endDate,
  });
}
