import 'package:equatable/equatable.dart';

abstract class ImageIntroEvent extends Equatable {
  const ImageIntroEvent();

  @override
  List<Object> get props => [];
}

class GetImageIntro extends ImageIntroEvent {}
