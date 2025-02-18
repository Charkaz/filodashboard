import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/project_entity.dart';
import '../../domain/repositories/project_repository.dart';
import '../datasources/project_remote_data_source.dart';
import '../models/project_model.dart';

@Injectable(as: ProjectRepository)
class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProjectRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<ProjectEntity>>> getProjects() async {
    if (await networkInfo.isConnected) {
      try {
        final projects = await remoteDataSource.getProjects();
        return Right(projects);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, ProjectEntity>> getProjectById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final project = await remoteDataSource.getProjectById(id);
        return Right(project);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, ProjectEntity>> createProject(
      ProjectEntity project) async {
    if (await networkInfo.isConnected) {
      try {
        final projectModel = ProjectModel(
          id: project.id,
          name: project.name,
          description: project.description,
          createdAt: project.createdAt,
          updatedAt: project.updatedAt,
          status: project.status,
          ownerId: project.ownerId,
        );
        final createdProject =
            await remoteDataSource.createProject(projectModel);
        return Right(createdProject);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, ProjectEntity>> updateProject(
      ProjectEntity project) async {
    if (await networkInfo.isConnected) {
      try {
        final projectModel = ProjectModel(
          id: project.id,
          name: project.name,
          description: project.description,
          createdAt: project.createdAt,
          updatedAt: project.updatedAt,
          status: project.status,
          ownerId: project.ownerId,
        );
        final updatedProject = await remoteDataSource.updateProject(
          projectModel.id,
          projectModel,
        );
        return Right(updatedProject);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteProject(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteProject(id);
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
