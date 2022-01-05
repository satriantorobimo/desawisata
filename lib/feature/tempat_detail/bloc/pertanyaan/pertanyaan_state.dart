import 'package:desa_wisata_nusantara/feature/tempat_detail/model/pertanyaan_model.dart';

import 'package:equatable/equatable.dart';

abstract class PertanyaanState extends Equatable {
  const PertanyaanState();

  @override
  List<Object> get props => [];
}

class PertanyaanInitial extends PertanyaanState {}

class PertanyaanLoading extends PertanyaanState {}

class PertanyaanLoaded extends PertanyaanState {
  const PertanyaanLoaded({this.items, this.hasReachedMax});
  final List<Items> items;

  final bool hasReachedMax;

  PertanyaanLoaded copyWith({List<Items> posts, bool hasReachedMax}) {
    return PertanyaanLoaded(
      items: posts ?? items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [items, hasReachedMax];
}

class PertanyaanError extends PertanyaanState {
  const PertanyaanError(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}
