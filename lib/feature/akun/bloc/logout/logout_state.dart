import 'package:desa_wisata_nusantara/feature/akun/model/logout_model.dart';
import 'package:equatable/equatable.dart';

abstract class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object> get props => [];
}

class LogoutInitial extends LogoutState {}

class LogoutLoading extends LogoutState {}

class LogoutLoaded extends LogoutState {
  const LogoutLoaded({this.logoutModel});
  final LogoutModel logoutModel;

  @override
  List<Object> get props => [logoutModel];
}

class LogoutError extends LogoutState {
  const LogoutError(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}

class LogoutException extends LogoutState {
  const LogoutException(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}
