import 'package:equatable/equatable.dart';

abstract class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object> get props => [];
}

class GetReview extends ReviewEvent {
  final String id;
  final int limit;
  final int page;

  GetReview(this.id, this.limit, this.page);
}
