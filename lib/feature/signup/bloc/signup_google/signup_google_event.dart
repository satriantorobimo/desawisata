import 'package:equatable/equatable.dart';

abstract class SignupGoogleEvent extends Equatable {
  const SignupGoogleEvent();

  @override
  List<Object> get props => [];
}

class AttempRegisterGoogle extends SignupGoogleEvent {
  final String token;

  AttempRegisterGoogle(this.token);
}
