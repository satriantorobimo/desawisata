import 'package:desa_wisata_nusantara/feature/list_category/model/list_category_model.dart';
import 'package:equatable/equatable.dart';

abstract class ListCategoryState extends Equatable {
  const ListCategoryState();

  @override
  List<Object> get props => [];
}

class ListCategoryInitial extends ListCategoryState {}

class ListCategoryLoading extends ListCategoryState {}

class ListCategoryLoaded extends ListCategoryState {
  const ListCategoryLoaded({this.items, this.hasReachedMax});
  final List<Items> items;

  final bool hasReachedMax;

  ListCategoryLoaded copyWith({List<Items> posts, bool hasReachedMax}) {
    return ListCategoryLoaded(
      items: posts ?? items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [items, hasReachedMax];
}

class ListCategoryError extends ListCategoryState {
  const ListCategoryError(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}
