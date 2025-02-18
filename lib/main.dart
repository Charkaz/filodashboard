import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'core/di/injection.dart';
import 'core/language/language_bloc.dart';
import 'core/theme/theme_bloc.dart';
import 'features/dashboard/domain/usecases/get_dashboard_data.dart';
import 'features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'features/dashboard/presentation/pages/dashboard_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await configureDependencies();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('tr'),
        Locale('ru'),
        Locale('az'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<ThemeBloc>(),
          ),
          BlocProvider(
            create: (context) => getIt<LanguageBloc>(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
          title: 'app.title'.tr(),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: themeState.themeData,
          home: BlocProvider(
            create: (context) => DashboardBloc(
              getDashboardData: getIt<GetDashboardData>(),
            )..add(GetDashboardDataEvent()),
            child: Scaffold(
              body: const DashboardPage(),
            ),
          ),
        );
      },
    );
  }
}
