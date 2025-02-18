import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/board_repository.dart';

@injectable
class DeleteCard implements UseCase<void, DeleteCardParams> {
  final BoardRepository repository;

  DeleteCard(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteCardParams params) {
    return repository.deleteCard(
      boardId: params.boardId,
      cardId: params.cardId,
    );
  }
}

class DeleteCardParams extends Equatable {
  final String boardId;
  final String cardId;

  const DeleteCardParams({
    required this.boardId,
    required this.cardId,
  });

  @override
  List<Object?> get props => [boardId, cardId];
}
