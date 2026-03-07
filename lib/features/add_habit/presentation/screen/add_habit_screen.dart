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

class AddHabitScreen extends StatelessWidget {
  const AddHabitScreen({super.key});

  String _formatDate(DateTime dt) =>
      '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';

  void _saveHabit(BuildContext context, AddHabitState state) {
    context.read<AddHabitBloc>().add(
      SaveHabit(
        state.selectedHabitType!,
        state.fromDate!,
        state.toDate!,
        onSuccess: () => context.pop(true),
        onError: (e) => ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e))),
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
            backgroundColor: AppColors.white,
            appBar: AppBar(
              title: const Text(
                'Add New Habit',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: AppColors.dark,
                ),
              ),
              backgroundColor: AppColors.white,
              elevation: 0,
            ),
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Habit', style: _labelStyle),
                      const SizedBox(height: 8),
                      _FieldTile(
                        label:
                            state.selectedHabitType?.label ?? 'Select a habit',
                        isSelected: state.selectedHabitType != null,
                        icon:
                            state.selectedHabitType?.icon ??
                            Icons.fitness_center_outlined,
                        enabled: true,
                        onTap: () => _showHabitSelector(context),
                      ),
                      const SizedBox(height: 20),
                      const Text('Start Date', style: _labelStyle),
                      const SizedBox(height: 8),
                      _FieldTile(
                        label: state.fromDate != null
                            ? _formatDate(state.fromDate!)
                            : 'Select start date',
                        isSelected: state.fromDate != null,
                        icon: Icons.calendar_today_outlined,
                        enabled: state.isFromDateEnabled,
                        onTap: () => _pickFromDate(context),
                      ),
                      const SizedBox(height: 20),
                      const Text('End Date', style: _labelStyle),
                      const SizedBox(height: 8),
                      _FieldTile(
                        label: state.toDate != null
                            ? _formatDate(state.toDate!)
                            : 'Select end date',
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
                      backgroundColor: AppColors.dark,
                      foregroundColor: AppColors.white,
                      disabledBackgroundColor: AppColors.muted,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Create Habit',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
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
