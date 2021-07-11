import 'package:first_app/shared/components/constants.dart';
import 'package:first_app/shared/cubit/states.dart';
import 'package:first_app/shared/network/local/shared_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  int currentIndex = 0;

  var isDark =
      SharedPreferencesHelper.getSharedLocalData(key: IS_DARK_THEME_MODE) !=
              null
          ? SharedPreferencesHelper.getSharedLocalData(key: IS_DARK_THEME_MODE)
          : false;

  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  void changeAppThemeMode() {
    isDark = !isDark;
    SharedPreferencesHelper.putSharedLocalData(
            key: IS_DARK_THEME_MODE, value: isDark)
        .then((value) {
      emit(AppChangeDarkThemeState());
    });
  }
}
