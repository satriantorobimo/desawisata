import 'package:desa_wisata_nusantara/feature/login/model/login_model.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  const LoginLoaded({this.loginModel});
  final LoginModel loginModel;

  @override
  List<Object> get props => [loginModel];
}

class LoginError extends LoginState {
  const LoginError(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}

class LoginException extends LoginState {
  const LoginException(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}
