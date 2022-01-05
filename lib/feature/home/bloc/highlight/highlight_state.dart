import 'package:desa_wisata_nusantara/feature/home/model/highlight_model.dart';
import 'package:equatable/equatable.dart';

abstract class HighlightState extends Equatable {
  const HighlightState();

  @override
  List<Object> get props => [];
}

class HighlightInitial extends HighlightState {}

class HighlightLoading extends HighlightState {}

class HighlightLoaded extends HighlightState {
  const HighlightLoaded({this.highlightModel});
  final HighlightModel highlightModel;

  @override
  List<Object> get props => [highlightModel];
}

class HighlightError extends HighlightState {
  const HighlightError(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}

class HighlightException extends HighlightState {
  const HighlightException(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}
