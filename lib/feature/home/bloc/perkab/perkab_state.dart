import 'package:desa_wisata_nusantara/feature/home/model/per_kab_model.dart';
import 'package:equatable/equatable.dart';

abstract class PerKabState extends Equatable {
  const PerKabState();

  @override
  List<Object> get props => [];
}

class PerKabInitial extends PerKabState {}

class PerKabLoading extends PerKabState {}

class PerKabLoaded extends PerKabState {
  const PerKabLoaded({this.perKabModel});
  final PerKabModel perKabModel;

  @override
  List<Object> get props => [perKabModel];
}

class PerKabError extends PerKabState {
  const PerKabError(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}

class PerKabException extends PerKabState {
  const PerKabException(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}
