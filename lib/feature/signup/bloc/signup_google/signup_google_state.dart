import 'package:desa_wisata_nusantara/feature/signup/model/google_signin_model.dart';
import 'package:equatable/equatable.dart';

abstract class SignupGoogleState extends Equatable {
  const SignupGoogleState();

  @override
  List<Object> get props => [];
}

class SignupGoogleInitial extends SignupGoogleState {}

class SignupGoogleLoading extends SignupGoogleState {}

class SignupGoogleLoaded extends SignupGoogleState {
  const SignupGoogleLoaded({this.googleSignupModel});
  final GoogleSignupModel googleSignupModel;

  @override
  List<Object> get props => [googleSignupModel];
}

class SignupGoogleError extends SignupGoogleState {
  const SignupGoogleError(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}

class SignupGoogleException extends SignupGoogleState {
  const SignupGoogleException(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}
