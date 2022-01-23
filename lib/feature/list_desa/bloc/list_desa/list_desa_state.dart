import 'package:desa_wisata_nusantara/feature/list_desa/model/list_desa_model.dart';

import 'package:equatable/equatable.dart';

abstract class ListDesaState extends Equatable {
  const ListDesaState();

  @override
  List<Object> get props => [];
}

class ListDesaInitial extends ListDesaState {}

class ListDesaLoading extends ListDesaState {}

class ListDesaLoaded extends ListDesaState {
  const ListDesaLoaded({this.items, this.hasReachedMax});
  final List<Items> items;

  final bool hasReachedMax;

  ListDesaLoaded copyWith({List<Items> posts, bool hasReachedMax}) {
    return ListDesaLoaded(
      items: posts ?? items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [items, hasReachedMax];
}

class ListDesaError extends ListDesaState {
  const ListDesaError(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}

class ListDesaException extends ListDesaState {
  const ListDesaException(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}
