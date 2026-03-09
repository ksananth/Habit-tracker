import 'package:flutter/material.dart';
import 'package:habittracker/core/theme/app_colors.dart';
import 'package:habittracker/features/habit_attendance/usecase/get_habit_attendance_usecase.dart';

class AttendanceList extends StatelessWidget {
  final List<AttendanceUI> attendances;

  const AttendanceList({super.key, required this.attendances});

  String _formatDate(DateTime dt) =>
      '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';

  @override
  Widget build(BuildContext context) {
    if (attendances.isEmpty) return const SizedBox.shrink();

    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: attendances.length,
        separatorBuilder: (_, _) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final item = attendances[index];
          final attended = item.isAttendanceMarked;
          final future = item.isFutureDate;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.cardLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  future
                      ? Icons.check_circle_outline
                      : attended
                          ? Icons.check_circle
                          : Icons.cancel,
                  size: 20,
                  color: future
                      ? Colors.grey
                      : attended
                          ? Colors.green
                          : Colors.redAccent,
                ),
                const SizedBox(width: 12),
                Text(
                  _formatDate(item.date),
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
    );
  }
}
