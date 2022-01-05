import 'package:equatable/equatable.dart';

abstract class PerKabEvent extends Equatable {
  const PerKabEvent();

  @override
  List<Object> get props => [];
}

class GetTotalPerKab extends PerKabEvent {}
