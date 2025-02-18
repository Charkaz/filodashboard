import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/board_repository.dart';

@injectable
class DeleteBoard implements UseCase<void, DeleteBoardParams> {
  final BoardRepository repository;

  DeleteBoard(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteBoardParams params) {
    return repository.deleteBoard(params.id);
  }
}

class DeleteBoardParams extends Equatable {
  final String id;

  const DeleteBoardParams({required this.id});

  @override
  List<Object?> get props => [id];
}
