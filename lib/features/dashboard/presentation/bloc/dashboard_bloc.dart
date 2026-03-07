import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habittracker/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:habittracker/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:habittracker/features/dashboard/usecase/get_dashboard_usecase.dart';


class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardUseCase _getDashboardUseCase;


  DashboardBloc(this._getDashboardUseCase) : super(const DashboardLoading()) {
    on<LoadHabit>(_onLoadHabitList);
  }

  Future<void> _onLoadHabitList(
      LoadHabit event,
      Emitter<DashboardState> emit,
      ) async {
    emit(const DashboardLoading());
    try {
      final response = await _getDashboardUseCase();
      emit(DashboardLoaded(List.empty()));
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }
}