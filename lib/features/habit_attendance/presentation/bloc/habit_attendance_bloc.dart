import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habittracker/features/habit_attendance/presentation/bloc/habit_attendance_event.dart';
import 'package:habittracker/features/habit_attendance/presentation/bloc/habit_attendance_state.dart';
import 'package:habittracker/features/habit_attendance/usecase/get_habit_attendance_usecase.dart';
import 'package:habittracker/features/habit_attendance/usecase/put_attendance_usecase.dart';

class HabitAttendanceBloc extends Bloc<HabitAttendanceEvent, HabitAttendanceState> {
  final GetHabitAttendanceUseCase _getAttendance;
  final PutAttendanceUseCase _putAttendance;

  HabitAttendanceBloc(this._getAttendance, this._putAttendance)
      : super(HabitAttendanceState(isLoading: true)) {
    on<LoadAttendance>(_onLoad);
    on<MarkAttendance>(_onMark);
  }

  Future<void> _onLoad(LoadAttendance event, Emitter<HabitAttendanceState> emit) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final attendances = await _getAttendance(event.habitId);
      final isTodayMarked = attendances.any((a) => !a.isFutureDate && a.isAttendanceMarked);
      emit(state.copyWith(
        attendances: attendances,
        isLoading: false,
        isTodayMarked: isTodayMarked,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onMark(MarkAttendance event, Emitter<HabitAttendanceState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _putAttendance(event.habitId, DateTime.now());
      add(LoadAttendance(event.habitId));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
