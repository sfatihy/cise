import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cise/product/themes/themeDark.dart';
import 'package:cise/product/themes/themeLight.dart';
import 'package:cise/viewModel/settingsState.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  bool darkOrLight = false; // true -> dark , false -> light

  Future chooseTheme() async {
    final prefs = await SharedPreferences.getInstance();

    final action = prefs.getBool("theme"); // true -> dark , false -> light

    if (action == false) {
      darkOrLight = false;
      emit(SettingsLoaded(themeLight));
    }
    else if (action == true) {
      darkOrLight = true;
      emit(SettingsLoaded(themeDark));
    }
    else {
      darkOrLight = true;
      emit(SettingsLoaded(themeDark));
    }
  }

  void toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();

    if(darkOrLight == true) {
      darkOrLight = false;
      prefs.setBool("theme", false);
      emit(SettingsLoaded(themeLight));
    }
    else {
      darkOrLight = true;
      prefs.setBool("theme", true);
      emit(SettingsLoaded(themeDark));
    }
  }

}