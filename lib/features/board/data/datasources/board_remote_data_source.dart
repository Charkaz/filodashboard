import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../models/board_model.dart';

abstract class BoardRemoteDataSource {
  Future<List<BoardModel>> getBoards();
  Future<BoardModel> getBoardById(String id);
  Future<BoardModel> createBoard(Map<String, dynamic> params);
  Future<BoardModel> updateBoard(String id, Map<String, dynamic> params);
  Future<void> deleteBoard(String id);
  Future<CardModel> createCard(String boardId, Map<String, dynamic> params);
  Future<CardModel> updateCard(
      String boardId, String cardId, Map<String, dynamic> params);
  Future<void> deleteCard(String boardId, String cardId);
}

@Injectable(as: BoardRemoteDataSource)
class BoardRemoteDataSourceImpl implements BoardRemoteDataSource {
  final Dio dio;

  BoardRemoteDataSourceImpl(this.dio);

  @override
  Future<List<BoardModel>> getBoards() async {
    final response = await dio.get('/boards');
    return (response.data as List)
        .map((json) => BoardModel.fromJson(json))
        .toList();
  }

  @override
  Future<BoardModel> getBoardById(String id) async {
    final response = await dio.get('/boards/$id');
    return BoardModel.fromJson(response.data);
  }

  @override
  Future<BoardModel> createBoard(Map<String, dynamic> params) async {
    final response = await dio.post('/boards', data: params);
    return BoardModel.fromJson(response.data);
  }

  @override
  Future<BoardModel> updateBoard(String id, Map<String, dynamic> params) async {
    final response = await dio.put('/boards/$id', data: params);
    return BoardModel.fromJson(response.data);
  }

  @override
  Future<void> deleteBoard(String id) async {
    await dio.delete('/boards/$id');
  }

  @override
  Future<CardModel> createCard(
      String boardId, Map<String, dynamic> params) async {
    final response = await dio.post('/boards/$boardId/cards', data: params);
    return CardModel.fromJson(response.data);
  }

  @override
  Future<CardModel> updateCard(
      String boardId, String cardId, Map<String, dynamic> params) async {
    final response =
        await dio.put('/boards/$boardId/cards/$cardId', data: params);
    return CardModel.fromJson(response.data);
  }

  @override
  Future<void> deleteCard(String boardId, String cardId) async {
    await dio.delete('/boards/$boardId/cards/$cardId');
  }
}
