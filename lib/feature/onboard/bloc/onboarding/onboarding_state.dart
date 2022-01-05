import 'package:desa_wisata_nusantara/feature/onboard/model/onboarding_model.dart';
import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

class OnboardingInitial extends OnboardingState {}

class OnboardingLoading extends OnboardingState {}

class OnboardingLoaded extends OnboardingState {
  const OnboardingLoaded({this.onboardingModel});
  final OnboardingModel onboardingModel;

  @override
  List<Object> get props => [onboardingModel];
}

class OnboardingError extends OnboardingState {
  const OnboardingError(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}

class OnboardingException extends OnboardingState {
  const OnboardingException(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}
