import 'package:desa_wisata_nusantara/feature/signup/domain/api/signup_api.dart';
import 'package:desa_wisata_nusantara/feature/signup/model/google_signin_model.dart';
import 'package:desa_wisata_nusantara/feature/signup/model/signup_model.dart';
import 'package:desa_wisata_nusantara/feature/signup/model/signup_request_model.dart';

class SignupRepo {
  final SignupApi signupApi = SignupApi();

  Future<SignupModel> attemptRegister(SignupRequestModel signupRequestModel) =>
      signupApi.attemptRegister(signupRequestModel);

  Future<GoogleSignupModel> attemptRegisterGoogle(String token) =>
      signupApi.attemptRegisterGoogle(token);

  Future<GoogleSignupModel> attemptRegisterFacebook(String token) =>
      signupApi.attemptRegisterFacebook(token);
}
