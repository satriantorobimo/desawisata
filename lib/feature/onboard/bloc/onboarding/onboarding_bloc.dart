import 'package:bloc/bloc.dart';
import 'package:desa_wisata_nusantara/feature/onboard/domain/repo/onboarding_repo.dart';
import 'package:desa_wisata_nusantara/feature/onboard/model/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'bloc.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc({@required this.onboardingRepo})
      : assert(onboardingRepo != null),
        super(OnboardingInitial());

  OnboardingModel onboardingModel;
  final OnboardingRepo onboardingRepo;

  OnboardingState get initialState => OnboardingInitial();

  @override
  Stream<OnboardingState> mapEventToState(
    OnboardingEvent event,
  ) async* {
    if (event is GetImageOnboarding) {
      yield OnboardingLoading();
      try {
        onboardingModel = await onboardingRepo.getImageOnboarding();
        if (onboardingModel.status) {
          yield OnboardingLoaded(onboardingModel: onboardingModel);
        } else {
          yield OnboardingError('no_data');
        }
      } catch (e) {
        yield OnboardingException('error');
      }
    }
  }
}
