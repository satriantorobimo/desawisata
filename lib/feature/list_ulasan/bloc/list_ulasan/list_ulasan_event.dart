import 'package:equatable/equatable.dart';

abstract class ListUlasanEvent extends Equatable {
  const ListUlasanEvent();

  @override
  List<Object> get props => [];
}

class GetMyReview extends ListUlasanEvent {
  final int page;
  final int limit;

  GetMyReview(this.page, this.limit);
}

class GetMyQuestion extends ListUlasanEvent {
  final int page;
  final int limit;

  GetMyQuestion(this.page, this.limit);
}
