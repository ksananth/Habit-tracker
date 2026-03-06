import 'package:habittracker/core/data/repositories/attendance_repository.dart';

class GetLastAttendanceUseCase {
  final AttendanceRepository _repository;

  GetLastAttendanceUseCase(this._repository);

  Future<DateTime?> call() => _repository.getLastAttendanceDate();
}
