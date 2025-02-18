import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/board_entity.dart';

abstract class BoardRepository {
  Future<Either<Failure, List<BoardEntity>>> getBoards();
  Future<Either<Failure, BoardEntity>> getBoardById(String id);
  Future<Either<Failure, BoardEntity>> createBoard({
    required String title,
    required String description,
  });
  Future<Either<Failure, BoardEntity>> updateBoard({
    required String id,
    String? title,
    String? description,
  });
  Future<Either<Failure, void>> deleteBoard(String id);
  Future<Either<Failure, CardEntity>> createCard({
    required String boardId,
    required String title,
    required String description,
    required String status,
    required int order,
  });
  Future<Either<Failure, CardEntity>> updateCard({
    required String boardId,
    required String cardId,
    String? title,
    String? description,
    String? status,
    int? order,
  });
  Future<Either<Failure, void>> deleteCard({
    required String boardId,
    required String cardId,
  });
}
