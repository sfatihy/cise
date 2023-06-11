
abstract class OnBoardingState {
  const OnBoardingState();
}

class OnBoardingInitial extends OnBoardingState {}

class OnBoardingLoading extends OnBoardingState {}

class OnBoardingLoaded extends OnBoardingState {}

class OnBoardingRefresh extends OnBoardingState {}

class OnBoardingError extends OnBoardingState {}