import '../../domain/habit_type.dart';

class AddHabitState {
  final List<HabitType> habitTypes;
  final HabitType? selectedHabitType;
  final DateTime? fromDate;
  final DateTime? toDate;
  final bool isLoading;

  AddHabitState({
    this.habitTypes = HabitType.values,
    this.selectedHabitType,
    this.fromDate,
    this.toDate,
    this.isLoading = false,
  });

  bool get isFromDateEnabled => selectedHabitType != null;
  bool get isToDateEnabled => fromDate != null;
  bool get isSubmitEnabled => toDate != null;

  AddHabitState copyWith({
    HabitType? selectedHabitType,
    DateTime? fromDate,
    DateTime? toDate,
    bool? isLoading,
    bool clearFromDate = false,
    bool clearToDate = false,
  }) {
    return AddHabitState(
      habitTypes: habitTypes,
      selectedHabitType: selectedHabitType ?? this.selectedHabitType,
      fromDate: clearFromDate ? null : fromDate ?? this.fromDate,
      toDate: clearToDate ? null : toDate ?? this.toDate,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
