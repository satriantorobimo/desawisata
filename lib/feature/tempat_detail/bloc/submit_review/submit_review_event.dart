import 'package:equatable/equatable.dart';

abstract class SubmitReviewEvent extends Equatable {
  const SubmitReviewEvent();

  @override
  List<Object> get props => [];
}

class AttemptSubmitReview extends SubmitReviewEvent {
  final String fileName1;
  final String fileName2;
  final String fileName3;
  final String wisataId;
  final double ratingPoint;
  final String visitedAt;
  final String review;
  final String title;
  final String visitedWith;

  AttemptSubmitReview(
      this.fileName1,
      this.fileName2,
      this.fileName3,
      this.wisataId,
      this.ratingPoint,
      this.visitedAt,
      this.review,
      this.title,
      this.visitedWith);
}
