import 'package:equatable/equatable.dart';

abstract class RefreshEvent extends Equatable {
  const RefreshEvent();

  @override
  List<Object> get props => [];
}

class AttemptRefresh extends RefreshEvent {}
