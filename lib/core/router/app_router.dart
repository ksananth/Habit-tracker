import 'package:go_router/go_router.dart';
import 'package:habittracker/features/splash/splash_screen.dart';
import 'package:habittracker/features/home/presentation/screen/home_screen.dart';

abstract class AppRoutes {
  static const splash = '/';
  static const home = '/home';
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
  ],
);