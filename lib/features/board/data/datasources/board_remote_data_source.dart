import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../models/board_model.dart';

part 'board_remote_data_source.g.dart';

@RestApi()
@lazySingleton
abstract class BoardRemoteDataSource {
  @factoryMethod
  factory BoardRemoteDataSource(@Named('dio') Dio dio) = _BoardRemoteDataSource;

  @GET('/boards')
  Future<List<BoardModel>> getBoards();

  @GET('/boards/{id}')
  Future<BoardModel> getBoardById(@Path('id') String id);

  @POST('/boards')
  Future<BoardModel> createBoard(@Body() Map<String, dynamic> params);

  @PUT('/boards/{id}')
  Future<BoardModel> updateBoard(
    @Path('id') String id,
    @Body() Map<String, dynamic> params,
  );

  @DELETE('/boards/{id}')
  Future<void> deleteBoard(@Path('id') String id);

  @POST('/boards/{boardId}/cards')
  Future<CardModel> createCard(
    @Path('boardId') String boardId,
    @Body() Map<String, dynamic> params,
  );

  @PUT('/boards/{boardId}/cards/{cardId}')
  Future<CardModel> updateCard(
    @Path('boardId') String boardId,
    @Path('cardId') String cardId,
    @Body() Map<String, dynamic> params,
  );

  @DELETE('/boards/{boardId}/cards/{cardId}')
  Future<void> deleteCard(
    @Path('boardId') String boardId,
    @Path('cardId') String cardId,
  );
}
