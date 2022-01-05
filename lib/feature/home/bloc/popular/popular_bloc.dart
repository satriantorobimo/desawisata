import 'package:bloc/bloc.dart';
import 'package:desa_wisata_nusantara/feature/home/domain/repo/highlight_repo.dart';
import 'package:desa_wisata_nusantara/feature/home/model/highlight_model.dart';
import 'package:flutter/material.dart';
import 'bloc.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  PopularBloc({@required this.highlightRepo})
      : assert(highlightRepo != null),
        super(PopularInitial());

  HighlightModel highlightModel;
  final HighlightRepo highlightRepo;

  PopularState get initialState => PopularInitial();

  @override
  Stream<PopularState> mapEventToState(
    PopularEvent event,
  ) async* {
    if (event is GetPopularContent) {
      yield PopularLoading();
      try {
        highlightModel = await highlightRepo.getPopularContent();
        if (highlightModel.status) {
          yield PopularLoaded(highlightModel: highlightModel);
        } else {
          yield PopularError('no_data');
        }
      } catch (e) {
        yield PopularException('error');
      }
    }
  }
}
