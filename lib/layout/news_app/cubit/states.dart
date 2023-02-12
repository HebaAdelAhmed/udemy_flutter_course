abstract class NewsAppStates {}

class NewsAppInitialState extends NewsAppStates {}

class NewsBottomNavState extends NewsAppStates {}

class NewsGetBusinessLoadingState extends NewsAppStates {}

class NewsGetBusinessDataSuccessfullyState extends NewsAppStates {}

class NewsGetBusinessDataErrorState extends NewsAppStates {
  final String error;
  NewsGetBusinessDataErrorState({
    required this.error
  });
}

class NewsGetScienceDataLoadingState extends NewsAppStates {}

class NewsGetScienceDataSuccessfullyState extends NewsAppStates {}

class NewsGetScienceDataErrorState extends NewsAppStates {
  final String error;
  NewsGetScienceDataErrorState({
    required this.error
});
}

class ChangeAppMode extends NewsAppStates {}

class NewsGetSportDataLoadingState extends NewsAppStates {}

class NewsGetSportDataSuccessfullyState extends NewsAppStates {}

class NewsGetSportDataErrorState extends NewsAppStates {
  final String error;

  NewsGetSportDataErrorState({
    required this.error
  });
}

class NewsGetSearchDataSuccessfullyState extends NewsAppStates {}

class NewsGetSearchDataErrorState extends NewsAppStates {
  final String error;

  NewsGetSearchDataErrorState({
    required this.error
  });
}