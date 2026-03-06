import '../../../core/data/repositories/attendance_repository.dart';

class GetLastSyncUseCase {
  final AttendanceRepository repository;

  GetLastSyncUseCase(this.repository);

  Future<DateTime?> execute() async {
    return await repository.getLastAttendanceDate();
  }
}