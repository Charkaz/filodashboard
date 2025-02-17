import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:country_flags/country_flags.dart';
import '../language/language_bloc.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.language),
      onSelected: (String languageCode) {
        context.setLocale(Locale(languageCode));
        context.read<LanguageBloc>().add(ChangeLanguageEvent(languageCode));
      },
      itemBuilder: (BuildContext context) => [
        _buildLanguageItem(
          context,
          'en',
          'language.en'.tr(),
          CountryFlag.fromCountryCode(
            'GB',
            height: 20,
            width: 30,
          ),
        ),
        _buildLanguageItem(
          context,
          'tr',
          'language.tr'.tr(),
          CountryFlag.fromCountryCode(
            'TR',
            height: 20,
            width: 30,
          ),
        ),
        _buildLanguageItem(
          context,
          'ru',
          'language.ru'.tr(),
          CountryFlag.fromCountryCode(
            'RU',
            height: 20,
            width: 30,
          ),
        ),
        _buildLanguageItem(
          context,
          'az',
          'language.az'.tr(),
          CountryFlag.fromCountryCode(
            'AZ',
            height: 20,
            width: 30,
          ),
        ),
      ],
    );
  }

  PopupMenuItem<String> _buildLanguageItem(
    BuildContext context,
    String languageCode,
    String languageName,
    Widget flag,
  ) {
    return PopupMenuItem<String>(
      value: languageCode,
      child: Row(
        children: [
          flag,
          const SizedBox(width: 10),
          Text(languageName),
        ],
      ),
    );
  }
}
