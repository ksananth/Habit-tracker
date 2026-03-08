import 'package:habittracker/core/data/repositories/attendance_repository.dart';

class PutAttendanceUseCase {
  final AttendanceRepository _repository;

  PutAttendanceUseCase(this._repository);

  Future<void> call(int habitId, DateTime date) => _repository.putAttendance(habitId, date);
}
