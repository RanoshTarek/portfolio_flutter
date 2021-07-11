import 'package:first_app/layout/news_layout/cubit/states.dart';
import 'package:first_app/modules/news_app/news_business/news_business.dart';
import 'package:first_app/modules/news_app/news_science/news_science.dart';
import 'package:first_app/modules/news_app/news_sport/news_sport.dart';
import 'package:first_app/shared/components/constants.dart';
import 'package:first_app/shared/network/remote/dio_helper_news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<String> titles = [
    "News Business",
    "News Sport",
    "News Science",
  ];
  List<Widget> bottomNavScreen = [
    NewsBusiness(),
    NewsSport(),
    NewsScience(),
  ];

  void changeBottomNavIndex(index) {
    currentIndex = index;
    if (index == 1) {
      getSportData();
    }
    if (index == 2) {
      getScienceData();
    }
    emit(BottomNavIndexState());
  }

  List<dynamic> business = [];

  void getBusinessData() {
    emit(NewsGetBusinessLoadingState());

    DioNewsHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': API_KEY,
    }).then((value) {
      business = value.data['articles'];
      print(value);
      emit(NewsGetBusinessSuccessfulState());
    }).catchError((onError) {
      print(onError.toString());
      emit(NewsGetBusinessErrorState(onError.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSportData() {
    emit(NewsGetSportLoadingState());
    if (sports.length == 0) {
      DioNewsHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': API_KEY,
      }).then((value) {
        sports = value.data['articles'];
        print(value);
        emit(NewsGetSportSuccessfulState());
      }).catchError((onError) {
        print(onError);
        emit(NewsGetSportErrorState(onError.toString()));
      });
    } else {
      emit(NewsGetSportSuccessfulState());
    }
  }

  List<dynamic> sciences = [];

  void getScienceData() {
    emit(NewsGetScienceLoadingState());
    if (sciences.length == 0) {
      DioNewsHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': API_KEY,
      }).then((value) {
        sciences = value.data['articles'];
        print(value);
        emit(NewsGetScienceSuccessfulState());
      }).catchError((onError) {
        print(onError);
        emit(NewsGetScienceErrorState(onError.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessfulState());
    }
  }

  List<dynamic> searchList = [];

  void getSearchData(String searchQuery) {
    if (searchQuery.isNotEmpty) {
      emit(NewsGetSearchLoadingState());
      DioNewsHelper.getData(url: 'v2/top-headlines', query: {
        'q': searchQuery,
        'apiKey': API_KEY,
      }).then((value) {
        searchList = value.data['articles'];
        print(value);
        emit(NewsGetSearchSuccessfulState());
      }).catchError((onError) {
        print(onError);
        emit(NewsGetSearchErrorState(onError.toString()));
      });
    } else {
      searchList.clear();
      emit(NewsGetSearchSuccessfulState());
    }
  }
}
