import 'package:desa_wisata_nusantara/feature/tempat_detail/model/tempat_detail_model.dart';
import 'package:equatable/equatable.dart';

abstract class TempatDetailState extends Equatable {
  const TempatDetailState();

  @override
  List<Object> get props => [];
}

class TempatDetailInitial extends TempatDetailState {}

class TempatDetailLoading extends TempatDetailState {}

class TempatDetailLoaded extends TempatDetailState {
  const TempatDetailLoaded({this.tempatDetailModel});
  final TempatDetailModel tempatDetailModel;

  @override
  List<Object> get props => [tempatDetailModel];
}

class TempatDetailError extends TempatDetailState {
  const TempatDetailError(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}

class TempatDetailException extends TempatDetailState {
  const TempatDetailException(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}
