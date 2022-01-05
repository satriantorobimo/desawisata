import 'package:bloc/bloc.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/domain/repo/tempat_detail_repo.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/model/submit_likes_model.dart';

import 'package:flutter/material.dart';
import 'bloc.dart';

class SubmitLikesBloc extends Bloc<SubmitLikesEvent, SubmitLikesState> {
  SubmitLikesBloc({@required this.tempatDetailRepo})
      : assert(tempatDetailRepo != null),
        super(SubmitLikesInitial());

  SubmitLikesModel submitLikesModel;
  final TempatDetailRepo tempatDetailRepo;

  SubmitLikesState get initialState => SubmitLikesInitial();

  @override
  Stream<SubmitLikesState> mapEventToState(
    SubmitLikesEvent event,
  ) async* {
    if (event is AttemptSubmitLikes) {
      yield SubmitLikesLoading();
      try {
        submitLikesModel =
            await tempatDetailRepo.submitLikes(event.id, event.isLiked, event.imei);
        if (submitLikesModel.status) {
          yield SubmitLikesLoaded(submitLikesModel: submitLikesModel);
        } else {
          yield SubmitLikesError('no_data');
        }
      } catch (e) {
        yield SubmitLikesException('error');
      }
    }
  }
}
