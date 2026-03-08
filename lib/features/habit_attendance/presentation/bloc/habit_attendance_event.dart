abstract class HabitAttendanceEvent {
  const HabitAttendanceEvent();
}

class LoadAttendance extends HabitAttendanceEvent {
  final int habitId;
  const LoadAttendance(this.habitId);
}

class MarkAttendance extends HabitAttendanceEvent {
  final int habitId;
  const MarkAttendance(this.habitId);
}
