import 'package:desa_wisata_nusantara/feature/tempat_detail/model/submit_likes_model.dart';
import 'package:equatable/equatable.dart';

abstract class SubmitLikesState extends Equatable {
  const SubmitLikesState();

  @override
  List<Object> get props => [];
}

class SubmitLikesInitial extends SubmitLikesState {}

class SubmitLikesLoading extends SubmitLikesState {}

class SubmitLikesLoaded extends SubmitLikesState {
  const SubmitLikesLoaded({this.submitLikesModel});
  final SubmitLikesModel submitLikesModel;

  @override
  List<Object> get props => [submitLikesModel];
}

class SubmitLikesError extends SubmitLikesState {
  const SubmitLikesError(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}

class SubmitLikesException extends SubmitLikesState {
  const SubmitLikesException(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}
