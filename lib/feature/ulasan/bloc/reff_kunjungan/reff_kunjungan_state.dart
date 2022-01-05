import 'package:desa_wisata_nusantara/feature/ulasan/model/reff_kunjugan_model.dart';
import 'package:equatable/equatable.dart';

abstract class ReffKunjunganState extends Equatable {
  const ReffKunjunganState();

  @override
  List<Object> get props => [];
}

class ReffKunjunganInitial extends ReffKunjunganState {}

class ReffKunjunganLoading extends ReffKunjunganState {}

class ReffKunjunganLoaded extends ReffKunjunganState {
  const ReffKunjunganLoaded({this.reffKunjunganModel});
  final ReffKunjunganModel reffKunjunganModel;

  @override
  List<Object> get props => [reffKunjunganModel];
}

class ReffKunjunganError extends ReffKunjunganState {
  const ReffKunjunganError(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}

class ReffKunjunganException extends ReffKunjunganState {
  const ReffKunjunganException(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}
