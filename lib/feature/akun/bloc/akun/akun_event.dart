import 'package:equatable/equatable.dart';

abstract class AkunEvent extends Equatable {
  const AkunEvent();

  @override
  List<Object> get props => [];
}

class GetAkun extends AkunEvent {}
