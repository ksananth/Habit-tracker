import 'package:habittracker/core/data/repositories/domain/attendance.dart' as domain;
import 'package:habittracker/core/data/models/attendance_entity.dart' as model;
import 'package:habittracker/core/data/models/habit_entity.dart';
import 'package:habittracker/objectbox.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AttendanceRepository {
  Future<DateTime?> getLastSync();
  Future<List<domain.Attendance>> getAttendance(int habitId);
  Future<void> putAttendance(int habitId, DateTime date);
}

class AttendanceRepositoryImpl implements AttendanceRepository {
  final Box<model.Attendance> _attendanceBox;
  final Box<HabitE> _habitBox;

  static const _lastSyncKey = 'last_sync';

  AttendanceRepositoryImpl(Store store)
      : _attendanceBox = store.box<model.Attendance>(),
        _habitBox = store.box<HabitE>();

  @override
  Future<DateTime?> getLastSync() async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getInt(_lastSyncKey);
    return timestamp != null
        ? DateTime.fromMillisecondsSinceEpoch(timestamp)
        : null;
  }

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

  domain.Attendance _toAttendance(model.Attendance m) {
    return domain.Attendance(
      id: m.id,
      habitId: m.habit.target?.id ?? 0,
      date: m.date,
    );
  }
}
