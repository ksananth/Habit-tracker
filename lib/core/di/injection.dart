import 'package:get_it/get_it.dart';
import 'package:habittracker/core/data/repositories/attendance_repository.dart';
import 'package:habittracker/core/data/repositories/habit_repository.dart';
import 'package:habittracker/features/home/domain/usecases/get_last_attendance_usecase.dart';
import 'package:habittracker/features/home/presentation/bloc/home_bloc.dart';
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

  // UseCases
  getIt.registerLazySingleton<GetLastAttendanceUseCase>(
    () => GetLastAttendanceUseCase(getIt<AttendanceRepository>()),
  );

  // Blocs
  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(getIt<GetLastAttendanceUseCase>()),
  );
}
