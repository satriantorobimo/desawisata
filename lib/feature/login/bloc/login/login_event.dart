import 'package:desa_wisata_nusantara/feature/signup/model/signup_request_model.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class AttempLogin extends LoginEvent {
  final SignupRequestModel signupRequestModel;

  AttempLogin(this.signupRequestModel);
}
