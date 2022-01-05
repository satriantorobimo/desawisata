import 'package:desa_wisata_nusantara/feature/splash/model/refresh_model.dart';
import 'package:equatable/equatable.dart';

abstract class RefreshState extends Equatable {
  const RefreshState();

  @override
  List<Object> get props => [];
}

class RefreshInitial extends RefreshState {}

class RefreshLoading extends RefreshState {}

class RefreshLoaded extends RefreshState {
  const RefreshLoaded({this.refreshModel});
  final RefreshModel refreshModel;

  @override
  List<Object> get props => [refreshModel];
}

class RefreshError extends RefreshState {
  const RefreshError(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}

class RefreshException extends RefreshState {
  const RefreshException(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}
