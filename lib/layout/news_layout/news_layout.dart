import 'package:first_app/layout/news_layout/cubit/cubit.dart';
import 'package:first_app/layout/news_layout/cubit/states.dart';
import 'package:first_app/modules/news_app/search/news_search.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var newsCubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              newsCubit.titles[newsCubit.currentIndex],
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    navigateTo(context: context, widget: NewsSearch());
                  }),
              IconButton(
                  icon: Icon(Icons.brightness_6),
                  onPressed: () {
                    AppCubit.get(context).changeAppThemeMode();
                  })
            ],
          ),
          body: newsCubit.bottomNavScreen[newsCubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: newsCubit.currentIndex,
            onTap: (index) {
              newsCubit.changeBottomNavIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.business), label: 'Business'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.sports_baseball_outlined), label: 'Sport'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.science_outlined), label: 'Science'),
            ],
          ),
        );
      },
    );
  }
}
