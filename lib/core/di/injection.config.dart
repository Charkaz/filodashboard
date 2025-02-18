// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:filodashboard/core/language/language_bloc.dart' as _i875;
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
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

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
    gh.factory<_i906.AuthRemoteDataSource>(
        () => _i906.AuthRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i529.AuthRepository>(
        () => _i912.AuthRepositoryImpl(gh<_i906.AuthRemoteDataSource>()));
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
    gh.factory<_i990.BoardRemoteDataSource>(
        () => _i990.BoardRemoteDataSourceImpl(gh<_i361.Dio>()));
    gh.singleton<_i875.LanguageBloc>(
        () => _i875.LanguageBloc(preferences: gh<_i460.SharedPreferences>()));
    gh.singleton<_i585.ThemeBloc>(
        () => _i585.ThemeBloc(preferences: gh<_i460.SharedPreferences>()));
    return this;
  }
}
