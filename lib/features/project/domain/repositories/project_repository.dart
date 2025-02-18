import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/project_entity.dart';

abstract class ProjectRepository {
  Future<Either<Failure, List<ProjectEntity>>> getProjects();
  Future<Either<Failure, ProjectEntity>> getProjectById(String id);
  Future<Either<Failure, ProjectEntity>> createProject(ProjectEntity project);
  Future<Either<Failure, ProjectEntity>> updateProject(ProjectEntity project);
  Future<Either<Failure, void>> deleteProject(String id);
}
