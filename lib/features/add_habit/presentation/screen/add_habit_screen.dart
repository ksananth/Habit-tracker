import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:habittracker/core/di/injection.dart';
import 'package:habittracker/core/router/app_router.dart';
import 'package:habittracker/core/theme/app_colors.dart';
import 'package:habittracker/features/add_habit/presentation/bloc/add_habit_bloc.dart';
import 'package:habittracker/features/add_habit/presentation/bloc/add_habit_event.dart';
import 'package:habittracker/features/add_habit/presentation/bloc/add_habit_state.dart';
import 'package:habittracker/features/add_habit/presentation/widgets/habit_selector_sheet.dart';
import 'package:habittracker/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:habittracker/core/constants/app_strings.dart';
import 'package:habittracker/features/dashboard/presentation/bloc/dashboard_event.dart';

class AddHabitScreen extends StatelessWidget {
  const AddHabitScreen({super.key});

  String _formatDate(DateTime dt) =>
      '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';

  void _saveHabit(BuildContext context, AddHabitState state) {
    final router = GoRouter.of(context);
    final messenger = ScaffoldMessenger.of(context);
    context.read<AddHabitBloc>().add(
      SaveHabit(
        state.selectedHabitType!,
        state.fromDate!,
        state.toDate!,
        onSuccess: () {
          getIt<DashboardBloc>().add(LoadHabit());
          router.pop();
        },
        onError: (e) => messenger.showSnackBar(SnackBar(content: Text(e))),
      ),
    );
  }

  void _showHabitSelector(BuildContext context) {
    final bloc = context.read<AddHabitBloc>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) =>
          BlocProvider.value(value: bloc, child: const HabitSelectorSheet()),
    );
  }

  Future<void> _pickFromDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(2100),
    );
    if (picked == null) return;
    context.read<AddHabitBloc>().add(SelectFromDate(picked));
  }

  Future<void> _pickToDate(BuildContext context, AddHabitState state) async {
    final from = state.fromDate!;
    final picked = await showDatePicker(
      context: context,
      initialDate: state.toDate ?? from.add(const Duration(days: 21)),
      firstDate: from,
      lastDate: DateTime(2100),
    );
    if (picked == null) return;
    context.read<AddHabitBloc>().add(SelectToDate(picked));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddHabitBloc>()..add(const LoadHabitTypes()),
      child: BlocBuilder<AddHabitBloc, AddHabitState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(AppStrings.addNewHabitTitle),
            ),
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(AppStrings.habit, style: _labelStyle),
                      const SizedBox(height: 8),
                      _FieldTile(
                        label:
                            state.selectedHabitType?.label ?? AppStrings.selectAHabit,
                        isSelected: state.selectedHabitType != null,
                        icon:
                            state.selectedHabitType?.icon ??
                            Icons.fitness_center_outlined,
                        enabled: true,
                        onTap: () => _showHabitSelector(context),
                      ),
                      const SizedBox(height: 20),
                      const Text(AppStrings.startDate, style: _labelStyle),
                      const SizedBox(height: 8),
                      _FieldTile(
                        label: state.fromDate != null
                            ? _formatDate(state.fromDate!)
                            : AppStrings.selectStartDate,
                        isSelected: state.fromDate != null,
                        icon: Icons.calendar_today_outlined,
                        enabled: state.isFromDateEnabled,
                        onTap: () => _pickFromDate(context),
                      ),
                      const SizedBox(height: 20),
                      const Text(AppStrings.endDate, style: _labelStyle),
                      const SizedBox(height: 8),
                      _FieldTile(
                        label: state.toDate != null
                            ? _formatDate(state.toDate!)
                            : AppStrings.selectEndDate,
                        isSelected: state.toDate != null,
                        icon: Icons.event_outlined,
                        enabled: state.isToDateEnabled,
                        onTap: () => _pickToDate(context, state),
                      ),
                    ],
                  ),
                ),
                if (state.isLoading)
                  const ColoredBox(
                    color: Colors.black38,
                    child: Center(child: CircularProgressIndicator()),
                  ),
              ],
            ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: state.isSubmitEnabled && !state.isLoading
                        ? () => _saveHabit(context, state)
                        : null,
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: AppColors.muted,
                    ),
                    child: const Text(AppStrings.createHabit),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

const _labelStyle = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w600,
  color: AppColors.muted,
);

class _FieldTile extends StatelessWidget {
  final String label;
  final bool isSelected;
  final bool enabled;
  final IconData icon;
  final VoidCallback onTap;

  const _FieldTile({
    required this.label,
    required this.isSelected,
    required this.enabled,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: enabled
              ? AppColors.cardLight
              : AppColors.cardLight.withOpacity(0.4),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: enabled ? AppColors.dark : AppColors.muted,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? AppColors.dark : AppColors.muted,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.muted),
          ],
        ),
      ),
    );
  }
}
