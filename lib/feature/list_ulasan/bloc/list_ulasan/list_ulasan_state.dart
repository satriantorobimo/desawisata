import 'package:desa_wisata_nusantara/feature/list_ulasan/model/my_question_model.dart'
    as question;
import 'package:desa_wisata_nusantara/feature/list_ulasan/model/my_review_model.dart'
    as review;
import 'package:equatable/equatable.dart';

abstract class ListUlasanState extends Equatable {
  const ListUlasanState();

  @override
  List<Object> get props => [];
}

class ListUlasanInitial extends ListUlasanState {}

class ListUlasanLoading extends ListUlasanState {}

class MyReviewLoaded extends ListUlasanState {
  const MyReviewLoaded({this.items, this.hasReachedMax});
  final List<review.Items> items;

  final bool hasReachedMax;

  MyReviewLoaded copyWith({
    List<review.Items> posts,
    bool hasReachedMax,
  }) {
    return MyReviewLoaded(
      items: posts ?? items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class MyQuestionLoaded extends ListUlasanState {
  const MyQuestionLoaded({this.items, this.hasReachedMax});
  final List<question.Items> items;

  final bool hasReachedMax;

  MyQuestionLoaded copyWith({
    List<question.Items> posts,
    bool hasReachedMax,
  }) {
    return MyQuestionLoaded(
      items: posts ?? items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [items, hasReachedMax];
}

class ListUlasanError extends ListUlasanState {
  const ListUlasanError(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}

class ListUlasanException extends ListUlasanState {
  const ListUlasanException(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}
