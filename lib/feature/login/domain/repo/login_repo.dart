import 'package:desa_wisata_nusantara/feature/login/domain/api/login_api.dart';
import 'package:desa_wisata_nusantara/feature/login/model/login_model.dart';
import 'package:desa_wisata_nusantara/feature/signup/model/signup_request_model.dart';

class LoginRepo {
  final LoginApi loginApi = LoginApi();

  Future<LoginModel> attemptLogin(SignupRequestModel signupRequestModel) =>
      loginApi.attemptLogin(signupRequestModel);
}
