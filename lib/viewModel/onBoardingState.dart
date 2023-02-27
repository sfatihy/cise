
abstract class OnBoardingState {
  const OnBoardingState();
}

class OnBoardingInitial extends OnBoardingState {}

class OnBoardingLoading extends OnBoardingState {}

class OnBoardingLoaded extends OnBoardingState {
  final int tagId;

  OnBoardingLoaded(this.tagId);
}

class OnBoardingError extends OnBoardingState {}