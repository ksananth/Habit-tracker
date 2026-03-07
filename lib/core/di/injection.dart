import 'package:get_it/get_it.dart';
import 'package:habittracker/core/data/repositories/attendance_repository.dart';
import 'package:habittracker/core/data/repositories/habit_repository.dart';
import 'package:habittracker/features/home/usecases/get_last_attendance_usecase.dart';
import 'package:habittracker/features/home/presentation/bloc/home_bloc.dart';
import 'package:habittracker/objectbox.g.dart';

import '../../features/dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../features/dashboard/usecase/get_dashboard_usecase.dart';

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

  getIt.registerFactory<DashboardBloc>(
        () => DashboardBloc(getIt<GetDashboardUseCase>()),
  );
}
