import 'package:habittracker/core/data/repositories/attendance_repository.dart';
import 'package:habittracker/core/data/repositories/domain/attendance.dart';

class GetHabitAttendanceUseCase {
  final AttendanceRepository _repository;

  GetHabitAttendanceUseCase(this._repository);

  Future<List<Attendance>> call(int habitId) => _repository.getAttendance(habitId);
}
