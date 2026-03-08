import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habittracker/features/habit_attendance/presentation/bloc/habit_attendance_state.dart';

import '../../usecase/get_habit_attendance_usecase.dart';
import 'habit_attendance_event.dart';

class HabitAttendanceBloc
    extends Bloc<HabitAttendanceEvent, HabitAttendanceState> {
  final GetHabitAttendanceUseCase _getHabitAttendanceUseCase;

  HabitAttendanceBloc(this._getHabitAttendanceUseCase)
    : super(HabitAttendanceLoading()) {
    on<PutAttendance>(_onPutAttendance);
  }

  Future<void> _onPutAttendance(
    PutAttendance event,
    Emitter<HabitAttendanceState> emit,
  ) async {
    try {
      final response = await _getHabitAttendanceUseCase(1);
    } catch (e) { }
  }
}
