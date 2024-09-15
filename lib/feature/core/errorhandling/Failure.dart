import 'package:equatable/equatable.dart';

// Learned: Use Either<Failure, YourSuccessResponse> if you want to handle errors,
// if you don't need the datatype you can use Either<Failure, Unit> (Miss you kotlin 😥)

// Learned: for each failure you have, create and exception class...

abstract class Failure extends Equatable {}

class NoInternetFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EmptyCacheFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

