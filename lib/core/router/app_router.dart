import 'package:go_router/go_router.dart';
import 'package:habittracker/features/add_habit/presentation/screen/add_habit_screen.dart';
import 'package:habittracker/features/dashboard/presentation/screen/dasboard_screen.dart';
import 'package:habittracker/features/habit_attendance/presentation/screen/habit_attendance_screen.dart';
import 'package:habittracker/features/splash/splash_screen.dart';
import 'package:habittracker/features/home/presentation/screen/home_screen.dart';

abstract class AppRoutes {
  static const splash = '/';
  static const home = '/home';
  static const dashboard = '/dashboard';
  static const addHabit = '/add-habit';
  static const habitAttendance = '/habit/:id/attendance';

  static String habitAttendancePath(int id) => '/habit/$id/attendance';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.dashboard,
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: AppRoutes.addHabit,
      builder: (context, state) => const AddHabitScreen(),
    ),
    GoRoute(
      path: AppRoutes.habitAttendance,
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return HabitAttendanceScreen(habitId: id);
      },
    ),
  ],
);
