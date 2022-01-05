import 'package:desa_wisata_nusantara/feature/tempat_detail/model/get_likes_model.dart';
import 'package:equatable/equatable.dart';

abstract class GetLikesState extends Equatable {
  const GetLikesState();

  @override
  List<Object> get props => [];
}

class GetLikesInitial extends GetLikesState {}

class GetLikesLoading extends GetLikesState {}

class GetLikesLoaded extends GetLikesState {
  const GetLikesLoaded({this.getLikesModel});
  final GetLikesModel getLikesModel;

  @override
  List<Object> get props => [getLikesModel];
}

class GetLikesError extends GetLikesState {
  const GetLikesError(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}

class GetLikesException extends GetLikesState {
  const GetLikesException(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}
