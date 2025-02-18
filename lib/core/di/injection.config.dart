// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:filodashboard/core/config/env_config.dart' as _i800;
import 'package:filodashboard/core/language/language_bloc.dart' as _i875;
import 'package:filodashboard/core/network/dio_client.dart' as _i903;
import 'package:filodashboard/core/network/network_info.dart' as _i341;
import 'package:filodashboard/core/theme/theme_bloc.dart' as _i585;
import 'package:filodashboard/features/auth/data/datasources/auth_remote_data_source.dart'
    as _i906;
import 'package:filodashboard/features/auth/data/repositories/auth_repository_impl.dart'
    as _i912;
import 'package:filodashboard/features/auth/domain/repositories/auth_repository.dart'
    as _i529;
import 'package:filodashboard/features/board/data/datasources/board_remote_data_source.dart'
    as _i990;
import 'package:filodashboard/features/board/domain/repositories/board_repository.dart'
    as _i575;
import 'package:filodashboard/features/board/domain/usecases/create_board.dart'
    as _i822;
import 'package:filodashboard/features/board/domain/usecases/delete_board.dart'
    as _i8;
import 'package:filodashboard/features/board/domain/usecases/delete_card.dart'
    as _i898;
import 'package:filodashboard/features/board/domain/usecases/update_board.dart'
    as _i993;
import 'package:filodashboard/features/dashboard/data/repositories/dashboard_repository_impl.dart'
    as _i85;
import 'package:filodashboard/features/dashboard/domain/repositories/dashboard_repository.dart'
    as _i42;
import 'package:filodashboard/features/dashboard/domain/usecases/get_dashboard_data.dart'
    as _i962;
import 'package:filodashboard/features/project/data/datasources/project_remote_data_source.dart'
    as _i597;
import 'package:filodashboard/features/project/data/repositories/project_repository_impl.dart'
    as _i262;
import 'package:filodashboard/features/project/domain/repositories/project_repository.dart'
    as _i953;
import 'package:filodashboard/features/project/domain/usecases/create_project.dart'
    as _i635;
import 'package:filodashboard/features/project/domain/usecases/update_project.dart'
    as _i642;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

const String _test = 'test';
const String _dev = 'dev';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioClient = _$DioClient();
    gh.factory<_i800.EnvConfig>(
      () => _i800.TestConfig(),
      registerFor: {_test},
    );
    gh.lazySingleton<_i990.BoardRemoteDataSource>(
        () => _i990.BoardRemoteDataSource(gh<_i361.Dio>(instanceName: 'dio')));
    gh.lazySingleton<_i597.ProjectRemoteDataSource>(() =>
        _i597.ProjectRemoteDataSource(gh<_i361.Dio>(instanceName: 'dio')));
    gh.factory<_i822.CreateBoard>(
        () => _i822.CreateBoard(gh<_i575.BoardRepository>()));
    gh.factory<_i8.DeleteBoard>(
        () => _i8.DeleteBoard(gh<_i575.BoardRepository>()));
    gh.factory<_i898.DeleteCard>(
        () => _i898.DeleteCard(gh<_i575.BoardRepository>()));
    gh.factory<_i993.UpdateBoard>(
        () => _i993.UpdateBoard(gh<_i575.BoardRepository>()));
    gh.factory<_i42.DashboardRepository>(() => _i85.DashboardRepositoryImpl());
    gh.factory<_i962.GetDashboardData>(
        () => _i962.GetDashboardData(gh<_i42.DashboardRepository>()));
    gh.factory<_i800.EnvConfig>(
      () => _i800.DevConfig(),
      registerFor: {_dev},
    );
    gh.factory<_i341.NetworkInfo>(
        () => _i341.NetworkInfoImpl(gh<_i973.InternetConnectionChecker>()));
    gh.factory<_i800.EnvConfig>(
      () => _i800.ProdConfig(),
      registerFor: {_prod},
    );
    gh.singleton<_i875.LanguageBloc>(
        () => _i875.LanguageBloc(preferences: gh<_i460.SharedPreferences>()));
    gh.singleton<_i585.ThemeBloc>(
        () => _i585.ThemeBloc(preferences: gh<_i460.SharedPreferences>()));
    gh.factory<_i953.ProjectRepository>(() => _i262.ProjectRepositoryImpl(
          gh<_i597.ProjectRemoteDataSource>(),
          gh<_i341.NetworkInfo>(),
        ));
    gh.lazySingleton<_i361.Dio>(() => dioClient.dio(gh<_i800.EnvConfig>()));
    gh.factory<_i906.AuthRemoteDataSource>(
        () => _i906.AuthRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i529.AuthRepository>(
        () => _i912.AuthRepositoryImpl(gh<_i906.AuthRemoteDataSource>()));
    gh.factory<_i635.CreateProject>(
        () => _i635.CreateProject(gh<_i953.ProjectRepository>()));
    gh.factory<_i642.UpdateProject>(
        () => _i642.UpdateProject(gh<_i953.ProjectRepository>()));
    return this;
  }
}

class _$DioClient extends _i903.DioClient {}
