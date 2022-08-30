import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/constants.dart';
import '../../utils/uiUtils.dart';


class AppLocalizationState {
  final Locale language;
  AppLocalizationState(this.language);
}

class AppLocalizationCubit extends Cubit<AppLocalizationState> {

  AppLocalizationCubit() : super(AppLocalizationState(UiUtils.getLocaleFromLanguageCode(defaultLanguageCode))) {
    changeLanguage("1");
  }

  void changeLanguage(String languageCode) {

    emit(AppLocalizationState(UiUtils.getLocaleFromLanguageCode(languageCode)));
  }
}
