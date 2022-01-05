import 'package:bloc/bloc.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/domain/repo/tempat_detail_repo.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/model/get_likes_model.dart';

import 'package:flutter/material.dart';
import 'bloc.dart';

class GetLikesBloc extends Bloc<GetLikesEvent, GetLikesState> {
  GetLikesBloc({@required this.tempatDetailRepo})
      : assert(tempatDetailRepo != null),
        super(GetLikesInitial());

  GetLikesModel getLikesModel;
  final TempatDetailRepo tempatDetailRepo;

  GetLikesState get initialState => GetLikesInitial();

  @override
  Stream<GetLikesState> mapEventToState(
    GetLikesEvent event,
  ) async* {
    if (event is AttemptGetLikes) {
      yield GetLikesLoading();
      try {
        getLikesModel = await tempatDetailRepo.getLikes(event.id, event.imei);
        if (getLikesModel.status) {
          yield GetLikesLoaded(getLikesModel: getLikesModel);
        } else {
          yield GetLikesError('no_data');
        }
      } catch (e) {
        yield GetLikesException('error');
      }
    }
  }
}
