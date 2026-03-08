import 'package:habittracker/core/data/repositories/domain/attendance.dart';

class HabitAttendanceState {
  final List<Attendance> attendances;
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
    List<Attendance>? attendances,
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
