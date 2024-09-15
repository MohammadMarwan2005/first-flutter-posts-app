part of 'adu_post_bloc.dart';

@immutable
sealed class ADUPostState extends Equatable {}

final class ADUInitial extends ADUPostState {
  @override
  List<Object?> get props => [];
}

final class IsLoadingState extends ADUPostState {
  @override
  List<Object?> get props => [];
}

final class FailureState extends ADUPostState {
  final String message;

  FailureState(this.message);
  @override
  List<Object?> get props => [];
}

final class SuccessState extends ADUPostState {
  final String message;

  SuccessState(this.message);

  @override
  List<Object?> get props => [message];
}