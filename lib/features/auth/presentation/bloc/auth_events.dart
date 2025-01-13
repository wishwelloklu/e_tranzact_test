import 'package:equatable/equatable.dart';

import '../../data/user_model.dart';

abstract class AuthEvents extends Equatable {}

final class LoginEvent extends AuthEvents {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);

  @override
  List<Object?> get props => [];
}

final class SignupEvent extends AuthEvents {
  final UserModel userModel;

  SignupEvent(this.userModel);
  @override
  List<Object?> get props => [];
}

final class LogoutEvent extends AuthEvents {
  @override
  List<Object?> get props => [];
}

final class CheckAuthStatusEvent extends AuthEvents {
  @override
  List<Object?> get props => [];
}
