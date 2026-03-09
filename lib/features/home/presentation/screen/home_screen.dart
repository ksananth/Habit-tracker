import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:habittracker/core/di/injection.dart';
import 'package:habittracker/core/router/app_router.dart';
import 'package:habittracker/core/theme/app_colors.dart';
import 'package:habittracker/features/home/presentation/bloc/home_bloc.dart';
import 'package:habittracker/features/home/presentation/bloc/home_event.dart';
import 'package:habittracker/core/constants/app_strings.dart';
import 'package:habittracker/features/home/presentation/bloc/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _formatLastSync(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeBloc>()..add(const LoadLastSync()),
      child: Scaffold(
        backgroundColor: AppColors.lime,
        body: SafeArea(
          child: Column(
            children: [
              Lottie.asset(
                'assets/lottie/home.json',
                width: double.infinity,
                height: 220,
                fit: BoxFit.contain,
                repeat: true,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is HomeError) {
                      return Column(
                        children: [
                          Text(
                            state.message,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: () =>
                                context.read<HomeBloc>().add(const LoadLastSync()),
                            child: const Text(AppStrings.retry),
                          ),
                        ],
                      );
                    }

                    if (state is HomeLoaded) {
                      final lastSync = state.lastSync;

                      if (lastSync != null) {
                        return Column(
                          children: [
                            const Text(
                              AppStrings.lastActivity,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.muted,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _formatLastSync(lastSync),
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                color: AppColors.dark,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Text(
                          AppStrings.startFirstHabit,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppColors.dark,
                          ),
                        );
                      }
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
              const SizedBox(height: 32),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () => context.go(AppRoutes.dashboard),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonPrimary,
                      foregroundColor: AppColors.buttonText,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      AppStrings.logActivity,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
