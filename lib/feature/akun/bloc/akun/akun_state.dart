import 'package:desa_wisata_nusantara/feature/akun/model/akun_model.dart';
import 'package:equatable/equatable.dart';

abstract class AkunState extends Equatable {
  const AkunState();

  @override
  List<Object> get props => [];
}

class AkunInitial extends AkunState {}

class AkunLoading extends AkunState {}

class AkunLoaded extends AkunState {
  const AkunLoaded({this.akunModel});
  final AkunModel akunModel;

  @override
  List<Object> get props => [akunModel];
}

class AkunError extends AkunState {
  const AkunError(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}

class AkunException extends AkunState {
  const AkunException(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}
