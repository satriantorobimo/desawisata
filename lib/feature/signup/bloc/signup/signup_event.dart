import 'package:desa_wisata_nusantara/feature/signup/model/signup_request_model.dart';
import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class AttempRegister extends SignupEvent {
  final SignupRequestModel signupRequestModel;

  AttempRegister(this.signupRequestModel);
}
