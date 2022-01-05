import 'package:equatable/equatable.dart';

abstract class SignupFbEvent extends Equatable {
  const SignupFbEvent();

  @override
  List<Object> get props => [];
}

class AttempRegisterFb extends SignupFbEvent {
  final String token;

  AttempRegisterFb(this.token);
}
