import 'package:flutter/material.dart';
import 'package:habittracker/core/theme/app_colors.dart';

const List<String> kHabitOptions = [
  'Exercise',
  'Reading',
  'Meditation',
  'Journaling',
  'Hydration',
  'Sleep',
  'Healthy Eating',
  'Learning',
  'Walking',
  'Stretching',
];

class HabitSelectorSheet extends StatelessWidget {
  final String? selected;
  final ValueChanged<String> onSelected;

  const HabitSelectorSheet({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Text(
              'Select a Habit',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.dark,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: kHabitOptions.length,
            itemBuilder: (context, index) {
              final habit = kHabitOptions[index];
              final isSelected = habit == selected;
              return ListTile(
                title: Text(
                  habit,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: AppColors.dark,
                  ),
                ),
                trailing: isSelected
                    ? const Icon(Icons.check_circle, color: AppColors.primary)
                    : null,
                onTap: () {
                  onSelected(habit);
                  Navigator.pop(context);
                },
              );
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
