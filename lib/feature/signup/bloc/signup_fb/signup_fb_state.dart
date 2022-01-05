import 'package:desa_wisata_nusantara/feature/signup/model/google_signin_model.dart';
import 'package:equatable/equatable.dart';

abstract class SignupFbState extends Equatable {
  const SignupFbState();

  @override
  List<Object> get props => [];
}

class SignupFbInitial extends SignupFbState {}

class SignupFbLoading extends SignupFbState {}

class SignupFbLoaded extends SignupFbState {
  const SignupFbLoaded({this.googleSignupModel});
  final GoogleSignupModel googleSignupModel;

  @override
  List<Object> get props => [googleSignupModel];
}

class SignupFbError extends SignupFbState {
  const SignupFbError(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}

class SignupFbException extends SignupFbState {
  const SignupFbException(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}
