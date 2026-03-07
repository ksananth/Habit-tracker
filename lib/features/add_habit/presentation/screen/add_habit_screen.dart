import 'package:flutter/material.dart';
import 'package:habittracker/core/theme/app_colors.dart';
import 'package:habittracker/features/add_habit/presentation/widgets/habit_selector_sheet.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  String? _selectedHabit;
  DateTime? _startDate;
  DateTime? _endDate;

  Future<void> _pickDate({required bool isStart}) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? (_startDate ?? now) : (_endDate ?? _startDate ?? now),
      firstDate: isStart ? DateTime(2000) : (_startDate ?? DateTime(2000)),
      lastDate: DateTime(2100),
    );
    if (picked == null) return;
    setState(() {
      if (isStart) {
        _startDate = picked;
        if (_endDate != null && _endDate!.isBefore(picked)) _endDate = null;
      } else {
        _endDate = picked;
      }
    });
  }

  void _showHabitSelector() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => HabitSelectorSheet(
        selected: _selectedHabit,
        onSelected: (habit) => setState(() => _selectedHabit = habit),
      ),
    );
  }

  String _formatDate(DateTime dt) =>
      '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';

  bool get _isValid =>
      _selectedHabit != null && _startDate != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(
          'Add New Habit',
          style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.dark),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Habit', style: _labelStyle),
            const SizedBox(height: 8),
            _FieldTile(
              label: _selectedHabit ?? 'Select a habit',
              hasValue: _selectedHabit != null,
              icon: Icons.fitness_center_outlined,
              onTap: _showHabitSelector,
            ),
            const SizedBox(height: 20),
            const Text('Start Date', style: _labelStyle),
            const SizedBox(height: 8),
            _FieldTile(
              label: _startDate != null ? _formatDate(_startDate!) : 'Select start date',
              hasValue: _startDate != null,
              icon: Icons.calendar_today_outlined,
              onTap: () => _pickDate(isStart: true),
            ),
            const SizedBox(height: 20),
            const Text('End Date', style: _labelStyle),
            const SizedBox(height: 8),
            _FieldTile(
              label: _endDate != null ? _formatDate(_endDate!) : 'Select end date (optional)',
              hasValue: _endDate != null,
              icon: Icons.event_outlined,
              onTap: () => _pickDate(isStart: false),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _isValid ? () {} : null,
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
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
  final bool hasValue;
  final IconData icon;
  final VoidCallback onTap;

  const _FieldTile({
    required this.label,
    required this.hasValue,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.cardLight,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.dark, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: hasValue ? AppColors.dark : AppColors.muted,
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
