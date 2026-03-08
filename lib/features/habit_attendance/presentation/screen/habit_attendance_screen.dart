import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habittracker/core/di/injection.dart';
import 'package:habittracker/core/theme/app_colors.dart';
import 'package:habittracker/features/habit_attendance/presentation/bloc/habit_attendance_bloc.dart';
import 'package:habittracker/features/habit_attendance/presentation/bloc/habit_attendance_event.dart';
import 'package:habittracker/features/habit_attendance/presentation/bloc/habit_attendance_state.dart';

class HabitAttendanceScreen extends StatelessWidget {
  final int habitId;

  const HabitAttendanceScreen({super.key, required this.habitId});

  String _formatDate(DateTime dt) =>
      '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HabitAttendanceBloc>()..add(LoadAttendance(habitId)),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: const Text(
            'Attendance',
            style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.dark),
          ),
          backgroundColor: AppColors.white,
          elevation: 0,
        ),
        body: BlocBuilder<HabitAttendanceBloc, HabitAttendanceState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.error != null) {
              return Center(
                child: Text(
                  state.error!,
                  style: const TextStyle(color: Colors.redAccent),
                ),
              );
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
                  child: Text(
                    'Mark your activity here to indicate that you performed your task today.',
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.muted,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: state.isTodayMarked
                          ? null
                          : () => context
                              .read<HabitAttendanceBloc>()
                              .add(MarkAttendance(habitId)),
                      icon: Icon(state.isTodayMarked
                          ? Icons.check_circle
                          : Icons.check_circle_outline),
                      label: Text(
                        state.isTodayMarked
                            ? 'Already accomplished today!'
                            : 'Yes, I accomplished this task today',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.isTodayMarked
                            ? AppColors.muted
                            : AppColors.dark,
                        foregroundColor: AppColors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                if (state.attendances.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text(
                        'No activity logged yet.',
                        style: TextStyle(color: AppColors.muted, fontSize: 14),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: state.attendances.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final attendance = state.attendances[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: AppColors.cardLight,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today_outlined,
                                  size: 18, color: AppColors.primary),
                              const SizedBox(width: 12),
                              Text(
                                _formatDate(attendance.date),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.dark,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
