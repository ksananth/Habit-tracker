class Habit {
  final int id;
  final String name;
  final DateTime? createdDate;
  final DateTime startDate;
  final DateTime? endDate;

  const Habit({
    required this.id,
    required this.name,
    this.createdDate,
    required this.startDate,
    this.endDate,
  });
}
