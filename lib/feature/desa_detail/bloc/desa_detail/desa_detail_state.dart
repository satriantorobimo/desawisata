import 'package:desa_wisata_nusantara/feature/desa_detail/model/desa_detail_model.dart';
import 'package:equatable/equatable.dart';

abstract class DesaDetailState extends Equatable {
  const DesaDetailState();

  @override
  List<Object> get props => [];
}

class DesaDetailInitial extends DesaDetailState {}

class DesaDetailLoading extends DesaDetailState {}

class DesaDetailLoaded extends DesaDetailState {
  const DesaDetailLoaded({this.desaDetailModel});
  final DesaDetailModel desaDetailModel;

  @override
  List<Object> get props => [desaDetailModel];
}

class DesaDetailError extends DesaDetailState {
  const DesaDetailError(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}

class DesaDetailException extends DesaDetailState {
  const DesaDetailException(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}
