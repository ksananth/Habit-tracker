import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habittracker/core/theme/app_colors.dart';
import 'package:habittracker/features/dashboard/domain/sort_order.dart';
import 'package:habittracker/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:habittracker/features/dashboard/presentation/bloc/dashboard_event.dart';

class SortSheet extends StatelessWidget {
  const SortSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sort by',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.dark,
            ),
          ),
          const SizedBox(height: 12),
          ...SortOrder.values.map(
            (order) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                order == SortOrder.name ? Icons.sort_by_alpha : Icons.calendar_today_outlined,
                color: AppColors.dark,
              ),
              title: Text(
                order.label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.dark,
                ),
              ),
              onTap: () {
                context.read<DashboardBloc>().add(SortHabits(order));
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
