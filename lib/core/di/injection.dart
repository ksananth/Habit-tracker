import 'package:get_it/get_it.dart';
import 'package:habittracker/core/data/repositories/attendance_repository.dart';
import 'package:habittracker/core/data/repositories/habit_repository.dart';
import 'package:habittracker/objectbox.g.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  final store = await openStore();
  getIt.registerSingleton<Store>(store);

  // Repositories
  getIt.registerLazySingleton<HabitRepository>(
    () => HabitRepositoryImpl(getIt<Store>()),
  );
  getIt.registerLazySingleton<AttendanceRepository>(
    () => AttendanceRepositoryImpl(getIt<Store>()),
  );
}
