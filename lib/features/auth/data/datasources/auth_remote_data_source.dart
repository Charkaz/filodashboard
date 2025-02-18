import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../models/user_model.dart';

part 'auth_remote_data_source.g.dart';

@RestApi()
@injectable
abstract class AuthRemoteDataSource {
  @factoryMethod
  factory AuthRemoteDataSource(Dio dio) = _AuthRemoteDataSource;

  @POST('/auth/login')
  Future<UserModel> login(@Body() Map<String, dynamic> body);

  @POST('/auth/register')
  Future<UserModel> register(@Body() Map<String, dynamic> body);

  @GET('/auth/me')
  Future<UserModel> getCurrentUser();

  @POST('/auth/logout')
  Future<void> logout();

  @PUT('/auth/profile')
  Future<UserModel> updateProfile(@Body() Map<String, dynamic> body);

  @PUT('/auth/password')
  Future<void> changePassword(@Body() Map<String, dynamic> body);
}
