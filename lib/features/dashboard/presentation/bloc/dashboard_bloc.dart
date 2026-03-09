import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habittracker/features/dashboard/domain/sort_order.dart';
import 'package:habittracker/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:habittracker/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:habittracker/features/dashboard/usecase/get_dashboard_usecase.dart';
import 'package:habittracker/features/dashboard/usecase/sort_habit_usecase.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardUseCase _getDashboardUseCase;
  final SortHabitUseCase _sortHabitUseCase;

  SortOrder _sortOrder = SortOrder.createdDate;

  DashboardBloc(this._getDashboardUseCase, this._sortHabitUseCase)
      : super(const DashboardLoading()) {
    on<LoadHabit>(_onLoadHabitList);
    on<SortHabits>(_onSortHabits);
  }

  Future<void> _onLoadHabitList(LoadHabit event, Emitter<DashboardState> emit) async {
    emit(const DashboardLoading());
    try {
      final response = await _getDashboardUseCase();
      if (response == null || response.isEmpty) {
        emit(DashboardEmpty());
      } else {
        final sorted = await _sortHabitUseCase(_sortOrder);
        emit(DashboardLoaded(sorted ?? response));
      }
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }

  Future<void> _onSortHabits(SortHabits event, Emitter<DashboardState> emit) async {
    _sortOrder = event.sortOrder;
    try {
      final sorted = await _sortHabitUseCase(_sortOrder);
      if (sorted == null || sorted.isEmpty) {
        emit(DashboardEmpty());
      } else {
        emit(DashboardLoaded(sorted));
      }
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }
}
