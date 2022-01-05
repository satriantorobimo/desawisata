import 'package:bloc/bloc.dart';
import 'package:desa_wisata_nusantara/feature/signup/domain/repo/signup_repo.dart';
import 'package:desa_wisata_nusantara/feature/signup/model/google_signin_model.dart';
import 'package:desa_wisata_nusantara/feature/signup/model/signup_model.dart';
import 'package:flutter/material.dart';
import 'bloc.dart';

class SignupFbBloc extends Bloc<SignupFbEvent, SignupFbState> {
  SignupFbBloc({@required this.signupRepo})
      : assert(signupRepo != null),
        super(SignupFbInitial());

  GoogleSignupModel googleSignupModel;
  final SignupRepo signupRepo;

  SignupFbState get initialState => SignupFbInitial();

  @override
  Stream<SignupFbState> mapEventToState(
    SignupFbEvent event,
  ) async* {
    if (event is AttempRegisterFb) {
      yield SignupFbLoading();
      try {
        googleSignupModel =
            await signupRepo.attemptRegisterFacebook(event.token);
        if (googleSignupModel.status) {
          yield SignupFbLoaded(googleSignupModel: googleSignupModel);
        } else {
          yield SignupFbError(googleSignupModel.message);
        }
      } catch (e) {
        yield SignupFbException('error');
      }
    }
  }
}
