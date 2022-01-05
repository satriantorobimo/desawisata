import 'package:bloc/bloc.dart';
import 'package:desa_wisata_nusantara/feature/signup/domain/repo/signup_repo.dart';
import 'package:desa_wisata_nusantara/feature/signup/model/signup_model.dart';
import 'package:flutter/material.dart';
import 'bloc.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc({@required this.signupRepo})
      : assert(signupRepo != null),
        super(SignupInitial());

  SignupModel signupModel;
  final SignupRepo signupRepo;

  SignupState get initialState => SignupInitial();

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    if (event is AttempRegister) {
      yield SignupLoading();
      try {
        signupModel =
            await signupRepo.attemptRegister(event.signupRequestModel);
        if (signupModel.status) {
          yield SignupLoaded(signupModel: signupModel);
        } else {
          yield SignupError(signupModel.message);
        }
      } catch (e) {
        yield SignupException('error');
      }
    }
  }
}
