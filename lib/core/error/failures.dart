import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  const Failure();
 
  @override 
  List<Object?> get props => [];
}

class ServerFailure extends Failure{
  final String message;

  const ServerFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class NetworkFailure extends Failure{
  final String message;
  
  const NetworkFailure(this.message);
  
  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {}

class PaymentFailure extends Failure {
  final String message;
  
  const PaymentFailure(this.message);
  
  @override
  List<Object> get props => [message];
}

String mapFailureToMessage(Failure failure) {
  if (failure is ServerFailure) return failure.message;
  if (failure is NetworkFailure) return "No internet connection";
  if (failure is PaymentFailure) return failure.message;
  if (failure is CacheFailure) return "Something went wrong with local storage";
  return "Unexpected error occurred";
}
