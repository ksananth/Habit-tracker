import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habittracker/features/add_habit/presentation/bloc/add_habit_event.dart';
import 'package:habittracker/features/add_habit/presentation/bloc/add_habit_state.dart';
import 'package:habittracker/features/add_habit/usecase/add_habit_usecase.dart';

class AddHabitBloc extends Bloc<AddHabitEvent, AddHabitState> {
  final AddHabitUseCase _addHabitUseCase;

  AddHabitBloc(this._addHabitUseCase) : super(AddHabitState()) {
    on<LoadHabitTypes>(_onLoadHabitTypes);
    on<SelectHabitType>(_onSelectHabitType);
    on<SelectFromDate>(_onSelectFromDate);
    on<SelectToDate>(_onSelectToDate);
    on<SaveHabit>(_onSaveHabit);
  }

  void _onLoadHabitTypes(LoadHabitTypes event, Emitter<AddHabitState> emit) {
    emit(AddHabitState());
  }

  void _onSelectHabitType(SelectHabitType event, Emitter<AddHabitState> emit) {
    emit(state.copyWith(
      selectedHabitType: event.habitType,
      clearFromDate: true,
      clearToDate: true,
    ));
  }

  void _onSelectFromDate(SelectFromDate event, Emitter<AddHabitState> emit) {
    emit(state.copyWith(fromDate: event.date, clearToDate: true));
  }

  void _onSelectToDate(SelectToDate event, Emitter<AddHabitState> emit) {
    emit(state.copyWith(toDate: event.date));
  }

  Future<void> _onSaveHabit(SaveHabit event, Emitter<AddHabitState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _addHabitUseCase(
        name: event.habitType.label,
        startDate: event.from,
        endDate: event.to,
      );
      emit(state.copyWith(isLoading: false));
      event.onSuccess();
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      event.onError(e.toString());
    }
  }
}
