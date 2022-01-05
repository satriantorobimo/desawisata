import 'package:equatable/equatable.dart';

abstract class DesaDetailEvent extends Equatable {
  const DesaDetailEvent();

  @override
  List<Object> get props => [];
}

class GetDesaDetailValue extends DesaDetailEvent {
  final String id;

  GetDesaDetailValue(this.id);
}
