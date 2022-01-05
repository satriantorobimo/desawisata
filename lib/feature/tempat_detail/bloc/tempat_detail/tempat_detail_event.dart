import 'package:equatable/equatable.dart';

abstract class TempatDetailEvent extends Equatable {
  const TempatDetailEvent();

  @override
  List<Object> get props => [];
}

class GetTempatDetail extends TempatDetailEvent {
  final String id;

  GetTempatDetail(this.id);
}
