import 'package:desa_wisata_nusantara/feature/signup/model/signup_model.dart';
import 'package:equatable/equatable.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupLoaded extends SignupState {
  const SignupLoaded({this.signupModel});
  final SignupModel signupModel;

  @override
  List<Object> get props => [signupModel];
}

class SignupError extends SignupState {
  const SignupError(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}

class SignupException extends SignupState {
  const SignupException(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}
