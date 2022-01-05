import 'package:bloc/bloc.dart';
import 'package:desa_wisata_nusantara/feature/intro/domain/repo/image_intro_repo.dart';
import 'package:desa_wisata_nusantara/feature/intro/model/image_intro_model.dart';
import 'package:flutter/material.dart';
import 'bloc.dart';

class ImageIntroBloc extends Bloc<ImageIntroEvent, ImageIntroState> {
  ImageIntroBloc({@required this.imageIntroRepo})
      : assert(imageIntroRepo != null),
        super(ImageIntroInitial());

  ImageIntroModel imageIntroModel;
  final ImageIntroRepo imageIntroRepo;

  ImageIntroState get initialState => ImageIntroInitial();

  @override
  Stream<ImageIntroState> mapEventToState(
    ImageIntroEvent event,
  ) async* {
    if (event is GetImageIntro) {
      yield ImageIntroLoading();
      try {
        imageIntroModel = await imageIntroRepo.getImageIntro();
        if (imageIntroModel.status) {
          yield ImageIntroLoaded(imageIntroModel: imageIntroModel);
        } else {
          yield ImageIntroError('no_data');
        }
      } catch (e) {
        yield ImageIntroException('error');
      }
    }
  }
}
