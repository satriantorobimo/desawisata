import 'package:desa_wisata_nusantara/feature/tempat_detail/model/submit_question_model.dart';

import 'package:equatable/equatable.dart';

abstract class SubmitQuestionState extends Equatable {
  const SubmitQuestionState();

  @override
  List<Object> get props => [];
}

class SubmitQuestionInitial extends SubmitQuestionState {}

class SubmitQuestionLoading extends SubmitQuestionState {}

class SubmitQuestionLoaded extends SubmitQuestionState {
  const SubmitQuestionLoaded({this.submitQuestionModel});
  final SubmitQuestionModel submitQuestionModel;

  @override
  List<Object> get props => [submitQuestionModel];
}

class SubmitQuestionError extends SubmitQuestionState {
  const SubmitQuestionError(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}
