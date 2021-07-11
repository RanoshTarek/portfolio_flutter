import 'package:bloc/bloc.dart';
import 'package:first_app/shared/BlocObserver.dart';
import 'package:first_app/shared/cubit/cubit.dart';
import 'package:first_app/shared/cubit/states.dart';
import 'package:first_app/shared/network/local/shared_helper.dart';
import 'package:first_app/shared/network/remote/dio_helper.dart';
import 'package:first_app/shared/network/remote/dio_helper_news.dart';
import 'package:first_app/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout/home_layout/cubit/cubit.dart';
import 'layout/news_layout/cubit/cubit.dart';
import 'layout/portfolio/portfolio_dart.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // to initial library before launch any screen
  Bloc.observer = MyBlocObserver();
  await SharedPreferencesHelper.init();
  DioHelper.init();
  DioNewsHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()),
        BlocProvider(create: (context) => NewsCubit()..getBusinessData()),
        BlocProvider(create: (BuildContext context) => ShopCubit()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: Portfolio(),
          );
        },
      ),
    );
  }
}
