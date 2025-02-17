import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/dashboard_data.dart';
import '../../domain/usecases/get_dashboard_data.dart';

// Events
abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class GetDashboardDataEvent extends DashboardEvent {}

class UpdateDashboardDataEvent extends DashboardEvent {
  final DashboardData data;

  const UpdateDashboardDataEvent(this.data);

  @override
  List<Object?> get props => [data];
}

// States
abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final DashboardData data;

  const DashboardLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError(this.message);

  @override
  List<Object?> get props => [message];
}

// Bloc
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardData getDashboardData;

  DashboardBloc({
    required this.getDashboardData,
  }) : super(DashboardInitial()) {
    on<GetDashboardDataEvent>(_onGetDashboardData);
    on<UpdateDashboardDataEvent>(_onUpdateDashboardData);
  }

  Future<void> _onGetDashboardData(
    GetDashboardDataEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());
    final result = await getDashboardData();
    result.fold(
      (failure) => emit(const DashboardError('Failed to load dashboard data')),
      (data) => emit(DashboardLoaded(data)),
    );
  }

  Future<void> _onUpdateDashboardData(
    UpdateDashboardDataEvent event,
    Emitter<DashboardState> emit,
  ) async {
    // TODO: Implement update logic
  }
}
