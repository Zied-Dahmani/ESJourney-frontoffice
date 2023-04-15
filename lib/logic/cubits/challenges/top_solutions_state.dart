abstract class TopSolutionsState {}

class TopSolutionsInitial extends TopSolutionsState {}

class TopSolutionsLoadInProgress extends TopSolutionsState {}

class TopSolutionsSuccess extends TopSolutionsState {
  final List<dynamic> topSolutions;

  TopSolutionsSuccess(this.topSolutions);
}

class TopSolutionsIsFailure extends TopSolutionsState {
  final String error;

  TopSolutionsIsFailure(this.error);
}
