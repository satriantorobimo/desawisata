import 'package:desa_wisata_nusantara/feature/search/model/search_model.dart';
import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  const SearchLoaded({this.searchModel});
  final SearchModel searchModel;

  @override
  List<Object> get props => [searchModel];
}

class SearchError extends SearchState {
  const SearchError(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}

class SearchException extends SearchState {
  const SearchException(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}
