abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class BottomNavIndexState extends NewsStates {}

class BottomNavScreenState extends NewsStates {}

class NewsGetBusinessLoadingState extends NewsStates {}

class NewsGetBusinessSuccessfulState extends NewsStates {}

class NewsGetBusinessErrorState extends NewsStates {
  final String error;

  NewsGetBusinessErrorState(this.error);
}

class NewsGetSportLoadingState extends NewsStates {}

class NewsGetSportSuccessfulState extends NewsStates {}

class NewsGetSportErrorState extends NewsStates {
  final String error;

  NewsGetSportErrorState(this.error);
}

class NewsGetScienceLoadingState extends NewsStates {}

class NewsGetScienceSuccessfulState extends NewsStates {}

class NewsGetScienceErrorState extends NewsStates {
  final String error;

  NewsGetScienceErrorState(this.error);
}

class NewsGetSearchLoadingState extends NewsStates {}

class NewsGetSearchSuccessfulState extends NewsStates {}

class NewsGetSearchErrorState extends NewsStates {
  final String error;

  NewsGetSearchErrorState(this.error);
}
