import 'package:habittracker/core/data/repositories/attendance_repository.dart';

class GetDashboardUseCase {

  final AttendanceRepository _repository;

  GetDashboardUseCase(this._repository);

  Future<DateTime?> call() => _repository.getLastAttendanceDate();


}