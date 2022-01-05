import 'package:equatable/equatable.dart';

abstract class GetLikesEvent extends Equatable {
  const GetLikesEvent();

  @override
  List<Object> get props => [];
}

class AttemptGetLikes extends GetLikesEvent {
  final String id;
  final String imei;

  AttemptGetLikes(this.id, this.imei);
}
