import 'package:desa_wisata_nusantara/feature/tempat_detail/model/review_model.dart';
import 'package:equatable/equatable.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object> get props => [];
}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewLoaded extends ReviewState {
  const ReviewLoaded({this.items, this.hasReachedMax, this.reviewModel});
  final List<Items> items;
  final ReviewModel reviewModel;
  final bool hasReachedMax;

  ReviewLoaded copyWith(
      {List<Items> posts, bool hasReachedMax, ReviewModel reviewModel}) {
    return ReviewLoaded(
        items: posts ?? items,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        reviewModel: reviewModel);
  }

  @override
  List<Object> get props => [items, hasReachedMax];
}

class ReviewError extends ReviewState {
  const ReviewError(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}
