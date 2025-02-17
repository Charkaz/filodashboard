import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Events
abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object?> get props => [];
}

class ChangeLanguageEvent extends LanguageEvent {
  final String languageCode;

  const ChangeLanguageEvent(this.languageCode);

  @override
  List<Object?> get props => [languageCode];
}

// State
class LanguageState extends Equatable {
  final String languageCode;

  const LanguageState({required this.languageCode});

  @override
  List<Object?> get props => [languageCode];
}

@singleton
class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final SharedPreferences preferences;
  static const String languageKey = 'languageCode';

  LanguageBloc({required this.preferences})
      : super(const LanguageState(languageCode: 'en')) {
    on<ChangeLanguageEvent>(_onChangeLanguage);
    _initLanguage();
  }

  void _initLanguage() {
    final savedLanguage = preferences.getString(languageKey) ?? 'en';
    emit(LanguageState(languageCode: savedLanguage));
  }

  Future<void> _onChangeLanguage(
    ChangeLanguageEvent event,
    Emitter<LanguageState> emit,
  ) async {
    await preferences.setString(languageKey, event.languageCode);
    emit(LanguageState(languageCode: event.languageCode));
  }
}
