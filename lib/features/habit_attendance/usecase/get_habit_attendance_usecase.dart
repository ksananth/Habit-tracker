import 'package:habittracker/core/data/repositories/attendance_repository.dart';
import 'package:habittracker/core/data/repositories/habit_repository.dart';

class GetHabitAttendanceUseCase {
  final AttendanceRepository _repository;
  final HabitRepository _habitRepo;

  GetHabitAttendanceUseCase(this._repository, this._habitRepo);

  Future<List<AttendanceUI>> call(int habitId) async {
    final habit = await _habitRepo.getById(habitId);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final dates = _generateDateRange(habit!.startDate, habit.endDate);

    final existingAttendance = await _repository.getAttendance(habitId);

    final attendedDates = existingAttendance
        .map((a) => _dateOnly(a.date))
        .toSet();

    return dates.map((date) {
      final dateOnly = _dateOnly(date);
      return AttendanceUI(
        date: date,
        isFutureDate: dateOnly.isAfter(today),
        isAttendanceMarked: attendedDates.contains(dateOnly),
      );
    }).toList();
  }

  List<DateTime> _generateDateRange(DateTime start, DateTime end) {
    final days = end.difference(start).inDays + 1;
    return List.generate(days, (i) => start.add(Duration(days: i)));
  }

  DateTime _dateOnly(DateTime dt) => DateTime(dt.year, dt.month, dt.day);
}

class AttendanceUI {
  final DateTime date;
  final bool isFutureDate;
  final bool isAttendanceMarked;

  const AttendanceUI({
    required this.date,
    required this.isFutureDate,
    required this.isAttendanceMarked,
  });
}