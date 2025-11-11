import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(const Locale('fa', 'IR'));

  void toggleLanguage() {
    emit(
      state.languageCode == 'fa'
          ? const Locale('en', 'US')
          : const Locale('fa', 'IR'),
    );
  }
}
