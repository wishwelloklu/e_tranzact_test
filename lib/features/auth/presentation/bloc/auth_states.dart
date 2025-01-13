import 'package:equatable/equatable.dart';
import 'package:etranzazct_test/features/auth/data/user_model.dart';

abstract class AuthStates extends Equatable {}

final class InitialState extends AuthStates {
  @override
  List<Object?> get props => [];
}

final class AuthProcessing extends AuthStates {
  @override
  List<Object?> get props => [];
}


final class AuthErrorState extends AuthStates {
  final String error;

  AuthErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

final class AuthenticatedState extends AuthStates {
  final UserModel userModel;

  AuthenticatedState(this.userModel);

  @override
  List<Object?> get props => [];
}

final class UnAuthenticatedState extends AuthStates {
  final String? error;

  UnAuthenticatedState([this.error]);
  @override
  List<Object?> get props => [error];
}
