import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/dashboard_data.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../models/dashboard_model.dart';

@Injectable(as: DashboardRepository)
class DashboardRepositoryImpl implements DashboardRepository {
  @override
  Future<Either<Failure, DashboardData>> getDashboardData() async {
    try {
      final mockData = DashboardModel(
        title: 'Dashboard',
        value: 100,
        lastUpdated: DateTime.now(),
      );
      return Right(mockData);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateDashboardData(DashboardData data) async {
    try {
      // TODO: Implement actual update logic
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
