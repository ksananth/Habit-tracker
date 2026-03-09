import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habittracker/core/constants/app_strings.dart';
import 'package:habittracker/core/theme/app_colors.dart';
import 'package:habittracker/features/add_habit/domain/habit_type.dart';
import 'package:habittracker/features/add_habit/presentation/bloc/add_habit_bloc.dart';
import 'package:habittracker/features/add_habit/presentation/bloc/add_habit_event.dart';

class HabitSelectorSheet extends StatelessWidget {
  const HabitSelectorSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final selected = context.read<AddHabitBloc>().state.selectedHabitType;
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Text(
              AppStrings.selectAHabitSheet,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.dark,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: HabitType.values.length,
              itemBuilder: (context, index) {
                final habit = HabitType.values[index];
                final isSelected = selected == habit;
                return ListTile(
                  leading: Icon(habit.icon, color: AppColors.dark),
                  title: Text(
                    habit.label,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: AppColors.dark,
                    ),
                  ),
                  trailing: isSelected
                      ? const Icon(Icons.check_circle, color: AppColors.primary)
                      : null,
                  onTap: () {
                    context.read<AddHabitBloc>().add(SelectHabitType(habit));
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
