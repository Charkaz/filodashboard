import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/board_entity.dart';
import '../repositories/board_repository.dart';

@injectable
class CreateBoard implements UseCase<BoardEntity, CreateBoardParams> {
  final BoardRepository repository;

  CreateBoard(this.repository);

  @override
  Future<Either<Failure, BoardEntity>> call(CreateBoardParams params) {
    return repository.createBoard(
      title: params.title,
      description: params.description,
    );
  }
}

class CreateBoardParams extends Equatable {
  final String title;
  final String description;

  const CreateBoardParams({
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [title, description];
}
