import 'package:bloc/bloc.dart';
import 'package:desa_wisata_nusantara/feature/home/domain/repo/highlight_repo.dart';
import 'package:desa_wisata_nusantara/feature/home/model/highlight_model.dart';
import 'package:flutter/material.dart';
import 'bloc.dart';

class HighlightBloc extends Bloc<HighlightEvent, HighlightState> {
  HighlightBloc({@required this.highlightRepo})
      : assert(highlightRepo != null),
        super(HighlightInitial());

  HighlightModel highlightModel;
  final HighlightRepo highlightRepo;

  HighlightState get initialState => HighlightInitial();

  @override
  Stream<HighlightState> mapEventToState(
    HighlightEvent event,
  ) async* {
    if (event is GetHighlightContent) {
      yield HighlightLoading();
      try {
        highlightModel = await highlightRepo.getHighlightContent();
        if (highlightModel.status) {
          yield HighlightLoaded(highlightModel: highlightModel);
        } else {
          yield HighlightError('no_data');
        }
      } catch (e) {
        yield HighlightException('error');
      }
    }
  }
}
