import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Events
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

class ToggleThemeEvent extends ThemeEvent {}

// State
class ThemeState extends Equatable {
  final bool isDarkMode;
  final ThemeData themeData;

  const ThemeState({
    required this.isDarkMode,
    required this.themeData,
  });

  @override
  List<Object?> get props => [isDarkMode, themeData];
}

@singleton
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SharedPreferences preferences;
  static const String themeKey = 'isDarkMode';

  ThemeBloc({required this.preferences})
      : super(ThemeState(
          isDarkMode: false,
          themeData: _getLightTheme(),
        )) {
    on<ToggleThemeEvent>(_onToggleTheme);
    _initTheme();
  }

  void _initTheme() {
    final isDarkMode = preferences.getBool(themeKey) ?? false;
    emit(ThemeState(
      isDarkMode: isDarkMode,
      themeData: isDarkMode ? _getDarkTheme() : _getLightTheme(),
    ));
  }

  Future<void> _onToggleTheme(
    ToggleThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    final isDarkMode = !state.isDarkMode;
    await preferences.setBool(themeKey, isDarkMode);
    emit(ThemeState(
      isDarkMode: isDarkMode,
      themeData: isDarkMode ? _getDarkTheme() : _getLightTheme(),
    ));
  }

  static ThemeData _getLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      ),
    );
  }

  static ThemeData _getDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.dark,
      ),
    );
  }
}
