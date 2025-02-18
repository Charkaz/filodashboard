import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/project_entity.dart';
import '../repositories/project_repository.dart';

@injectable
class CreateProject implements UseCase<ProjectEntity, Params> {
  final ProjectRepository repository;

  CreateProject(this.repository);

  @override
  Future<Either<Failure, ProjectEntity>> call(Params params) async {
    return await repository.createProject(params.project);
  }
}

class Params extends Equatable {
  final ProjectEntity project;

  const Params({required this.project});

  @override
  List<Object?> get props => [project];
}
