import 'package:desa_wisata_nusantara/feature/intro/model/image_intro_model.dart';
import 'package:equatable/equatable.dart';

abstract class ImageIntroState extends Equatable {
  const ImageIntroState();

  @override
  List<Object> get props => [];
}

class ImageIntroInitial extends ImageIntroState {}

class ImageIntroLoading extends ImageIntroState {}

class ImageIntroLoaded extends ImageIntroState {
  const ImageIntroLoaded({this.imageIntroModel});
  final ImageIntroModel imageIntroModel;

  @override
  List<Object> get props => [imageIntroModel];
}

class ImageIntroError extends ImageIntroState {
  const ImageIntroError(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}

class ImageIntroException extends ImageIntroState {
  const ImageIntroException(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}
