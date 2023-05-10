

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoadInProgress extends PostState {}

class PostIsSuccess extends PostState {
  final List<dynamic> posts;
  PostIsSuccess(this.posts);
}

class PostIsFailure extends PostState {
  final String error;

  PostIsFailure(this.error);
}