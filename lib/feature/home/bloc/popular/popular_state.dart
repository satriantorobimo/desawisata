import 'package:desa_wisata_nusantara/feature/home/model/highlight_model.dart';
import 'package:equatable/equatable.dart';

abstract class PopularState extends Equatable {
  const PopularState();

  @override
  List<Object> get props => [];
}

class PopularInitial extends PopularState {}

class PopularLoading extends PopularState {}

class PopularLoaded extends PopularState {
  const PopularLoaded({this.highlightModel});
  final HighlightModel highlightModel;

  @override
  List<Object> get props => [highlightModel];
}

class PopularError extends PopularState {
  const PopularError(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}

class PopularException extends PopularState {
  const PopularException(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}
