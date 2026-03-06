import 'package:habittracker/core/data/repositories/domain/attendance.dart' as domain;
import 'package:habittracker/core/data/models/attendance_entity.dart' as model;
import 'package:habittracker/core/data/models/habit_entity.dart';
import 'package:habittracker/objectbox.g.dart';

abstract class AttendanceRepository {
  Future<List<domain.Attendance>> getAttendance(int habitId);
  Future<void> putAttendance(int habitId, DateTime date);
  Future<DateTime?> getLastAttendanceDate();}

class AttendanceRepositoryImpl implements AttendanceRepository {
  final Box<model.Attendance> _attendanceBox;
  final Box<HabitE> _habitBox;

  AttendanceRepositoryImpl(Store store)
      : _attendanceBox = store.box<model.Attendance>(),
        _habitBox = store.box<HabitE>();

  @override
  Future<List<domain.Attendance>> getAttendance(int habitId) async {
    final query = _attendanceBox.query(Attendance_.habit.equals(habitId)).build();
    final results = query.find();
    query.close();
    return results.map(_toAttendance).toList();
  }

  @override
  Future<void> putAttendance(int habitId, DateTime date) async {
    final habit = _habitBox.get(habitId);
    if (habit != null) {
      final attendance = model.Attendance(date: date)..habit.target = habit;
      _attendanceBox.put(attendance);
    }
  }

  @override
  Future<DateTime?> getLastAttendanceDate() async {
    final query = _attendanceBox
        .query()
        .order(Attendance_.date, flags: Order.descending) // newest first
        .build();

    try {
      final latest = query.findFirst();
      return latest?.date;
    } finally {
      query.close();
    }
  }

  domain.Attendance _toAttendance(model.Attendance m) {
    return domain.Attendance(
      id: m.id,
      habitId: m.habit.target?.id ?? 0,
      date: m.date,
    );
  }
}
