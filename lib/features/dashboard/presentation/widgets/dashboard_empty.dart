import 'package:flutter/material.dart';
import 'package:habittracker/core/constants/app_strings.dart';
import 'package:habittracker/core/theme/app_colors.dart';

class DashboardEmptyView extends StatelessWidget {
  const DashboardEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.inbox_outlined, size: 96, color: AppColors.muted),
          SizedBox(height: 16),
          Text(
            AppStrings.noHabitsYet,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.dark,
            ),
          ),
          SizedBox(height: 8),
          Text(
            AppStrings.addHabitToStart,
            style: TextStyle(fontSize: 14, color: AppColors.muted),
          ),
        ],
      ),
    );
  }
}
