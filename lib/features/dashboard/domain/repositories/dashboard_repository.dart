import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/dashboard_data.dart';

abstract class DashboardRepository {
  Future<Either<Failure, DashboardData>> getDashboardData();
  Future<Either<Failure, void>> updateDashboardData(DashboardData data);
}
