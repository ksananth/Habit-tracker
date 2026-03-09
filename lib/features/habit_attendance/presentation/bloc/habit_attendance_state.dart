import 'package:habittracker/features/habit_attendance/usecase/get_habit_attendance_usecase.dart';

class HabitAttendanceState {
  final List<AttendanceUI> attendances;
  final bool isLoading;
  final bool isTodayMarked;
  final String? error;

  HabitAttendanceState({
    this.attendances = const [],
    this.isLoading = false,
    this.isTodayMarked = false,
    this.error,
  });

  HabitAttendanceState copyWith({
    List<AttendanceUI>? attendances,
    DateTime? startDate,
    bool? isLoading,
    bool? isTodayMarked,
    String? error,
    bool clearError = false,
  }) {
    return HabitAttendanceState(
      attendances: attendances ?? this.attendances,
      isLoading: isLoading ?? this.isLoading,
      isTodayMarked: isTodayMarked ?? this.isTodayMarked,
      error: clearError ? null : error ?? this.error,
    );
  }
}
