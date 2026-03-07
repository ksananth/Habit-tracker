import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:habittracker/core/di/injection.dart';
import 'package:habittracker/core/router/app_router.dart';
import 'package:habittracker/core/theme/app_colors.dart';
import 'package:habittracker/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:habittracker/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:habittracker/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:habittracker/features/dashboard/presentation/widgets/dashboard_empty.dart' show DashboardEmptyView;
import 'package:habittracker/features/dashboard/presentation/widgets/habit_list.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DashboardBloc>()..add(LoadHabit()),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: const Text(
            'My Habits',
            style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.dark),
          ),
          backgroundColor: AppColors.white,
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.dark,
          child: const Icon(Icons.filter_list, color: AppColors.white),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => context.go(AppRoutes.home),
                    icon: const Icon(Icons.home_outlined),
                    label: const Text('Home'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.dark,
                      side: const BorderSide(color: AppColors.dark),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => context.push(AppRoutes.addHabit),
                    icon: const Icon(Icons.add),
                    label: const Text('Add new Habit'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.dark,
                      foregroundColor: AppColors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is DashboardError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.redAccent),
                ),
              );
            }

            if (state is DashboardEmpty) {
              return const DashboardEmptyView();
            }

            if (state is DashboardLoaded) {
              return HabitList(habits: state.habits);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}