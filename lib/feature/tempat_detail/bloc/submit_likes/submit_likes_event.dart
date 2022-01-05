import 'package:equatable/equatable.dart';

abstract class SubmitLikesEvent extends Equatable {
  const SubmitLikesEvent();

  @override
  List<Object> get props => [];
}

class AttemptSubmitLikes extends SubmitLikesEvent {
  final String id;
  final bool isLiked;
  final String imei;

  AttemptSubmitLikes(this.id, this.isLiked, this.imei);
}
