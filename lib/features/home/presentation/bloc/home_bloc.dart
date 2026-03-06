import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habittracker/features/home/domain/usecases/get_last_attendance_usecase.dart';
import 'package:habittracker/features/home/presentation/bloc/home_event.dart';
import 'package:habittracker/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetLastAttendanceUseCase _getLastAttendanceUseCase;

  HomeBloc(this._getLastAttendanceUseCase) : super(const HomeInitial()) {
    on<LoadLastSync>(_onLoadLastSync);
  }

  Future<void> _onLoadLastSync(
    LoadLastSync event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    try {
      final lastSync = await _getLastAttendanceUseCase();
      emit(HomeLoaded(lastSync: lastSync));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
