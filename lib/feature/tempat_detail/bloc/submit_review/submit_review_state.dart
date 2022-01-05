import 'package:desa_wisata_nusantara/feature/tempat_detail/model/submit_review_model.dart';
import 'package:equatable/equatable.dart';

abstract class SubmitReviewState extends Equatable {
  const SubmitReviewState();

  @override
  List<Object> get props => [];
}

class SubmitReviewInitial extends SubmitReviewState {}

class SubmitReviewLoading extends SubmitReviewState {}

class SubmitReviewLoaded extends SubmitReviewState {
  const SubmitReviewLoaded({this.submitReviewModel});
  final SubmitReviewModel submitReviewModel;

  @override
  List<Object> get props => [submitReviewModel];
}

class SubmitReviewError extends SubmitReviewState {
  const SubmitReviewError(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}

class SubmitReviewException extends SubmitReviewState {
  const SubmitReviewException(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}
