import 'package:bloc/bloc.dart';
import 'package:desa_wisata_nusantara/feature/signup/domain/repo/signup_repo.dart';
import 'package:desa_wisata_nusantara/feature/signup/model/google_signin_model.dart';
import 'package:desa_wisata_nusantara/feature/signup/model/signup_model.dart';
import 'package:flutter/material.dart';
import 'bloc.dart';

class SignupGoogleBloc extends Bloc<SignupGoogleEvent, SignupGoogleState> {
  SignupGoogleBloc({@required this.signupRepo})
      : assert(signupRepo != null),
        super(SignupGoogleInitial());

  GoogleSignupModel googleSignupModel;
  final SignupRepo signupRepo;

  SignupGoogleState get initialState => SignupGoogleInitial();

  @override
  Stream<SignupGoogleState> mapEventToState(
    SignupGoogleEvent event,
  ) async* {
    if (event is AttempRegisterGoogle) {
      yield SignupGoogleLoading();
      try {
        googleSignupModel = await signupRepo.attemptRegisterGoogle(event.token);
        if (googleSignupModel.status) {
          yield SignupGoogleLoaded(googleSignupModel: googleSignupModel);
        } else {
          yield SignupGoogleError(googleSignupModel.message);
        }
      } catch (e) {
        yield SignupGoogleException('error');
      }
    }
  }
}
