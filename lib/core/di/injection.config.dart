// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:filodashboard/core/language/language_bloc.dart' as _i875;
import 'package:filodashboard/core/theme/theme_bloc.dart' as _i585;
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
    gh.factory<_i42.DashboardRepository>(() => _i85.DashboardRepositoryImpl());
    gh.factory<_i962.GetDashboardData>(
        () => _i962.GetDashboardData(gh<_i42.DashboardRepository>()));
    gh.singleton<_i875.LanguageBloc>(
        () => _i875.LanguageBloc(preferences: gh<_i460.SharedPreferences>()));
    gh.singleton<_i585.ThemeBloc>(
        () => _i585.ThemeBloc(preferences: gh<_i460.SharedPreferences>()));
    return this;
  }
}
