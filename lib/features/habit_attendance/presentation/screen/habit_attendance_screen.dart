import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habittracker/features/habit_attendance/presentation/bloc/habit_attendance_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../bloc/habit_attendance_state.dart';

class HabitAttendanceScreen extends StatelessWidget {
  const HabitAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF121212),
        appBar: AppBar(
          title: const Text(
            'My Habits',
            style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.dark),
          ),
          backgroundColor: AppColors.white,
          elevation: 0,
        ),
      body: BlocBuilder<HabitAttendanceBloc, HabitAttendanceState>(
        builder: (context, state) {
          if (state is HabitAttendanceLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HabitAttendanceError) {
            return Center(
              child: Text(
                "error",
                style: const TextStyle(color: Colors.redAccent),
              ),
            );
          }

          if (state is HabitAttendanceEmpty) {
            return  Center(
              child: Text(
                "Empty",
                style: const TextStyle(color: Colors.redAccent),
              ),
            );
          }

          if (state is HabitAttendanceData) {
            return  Center(
              child: Text(
                "Data",
                style: const TextStyle(color: Colors.redAccent),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),

    );
  }

}