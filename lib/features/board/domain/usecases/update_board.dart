import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/board_entity.dart';
import '../repositories/board_repository.dart';

@injectable
class UpdateBoard implements UseCase<BoardEntity, UpdateBoardParams> {
  final BoardRepository repository;

  UpdateBoard(this.repository);

  @override
  Future<Either<Failure, BoardEntity>> call(UpdateBoardParams params) {
    return repository.updateBoard(
      id: params.id,
      title: params.title,
      description: params.description,
    );
  }
}

class UpdateBoardParams extends Equatable {
  final String id;
  final String? title;
  final String? description;

  const UpdateBoardParams({
    required this.id,
    this.title,
    this.description,
  });

  @override
  List<Object?> get props => [id, title, description];
}
