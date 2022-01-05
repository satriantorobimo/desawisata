import 'package:bloc/bloc.dart';
import 'package:desa_wisata_nusantara/feature/login/domain/repo/login_repo.dart';
import 'package:desa_wisata_nusantara/feature/login/model/login_model.dart';
import 'package:flutter/material.dart';
import 'bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({@required this.loginRepo})
      : assert(loginRepo != null),
        super(LoginInitial());

  LoginModel loginModel;
  final LoginRepo loginRepo;

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is AttempLogin) {
      yield LoginLoading();
      try {
        loginModel = await loginRepo.attemptLogin(event.signupRequestModel);
        if (loginModel.status) {
          yield LoginLoaded(loginModel: loginModel);
        } else {
          yield LoginError(loginModel.message);
        }
      } catch (e) {
        yield LoginException('error');
      }
    }
  }
}
