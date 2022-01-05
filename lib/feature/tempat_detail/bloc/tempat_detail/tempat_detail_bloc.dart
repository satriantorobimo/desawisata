import 'package:bloc/bloc.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/domain/repo/tempat_detail_repo.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/model/tempat_detail_model.dart';
import 'package:flutter/material.dart';
import 'bloc.dart';

class TempatDetailBloc extends Bloc<TempatDetailEvent, TempatDetailState> {
  TempatDetailBloc({@required this.tempatDetailRepo})
      : assert(tempatDetailRepo != null),
        super(TempatDetailInitial());

  TempatDetailModel tempatDetailModel;
  final TempatDetailRepo tempatDetailRepo;

  TempatDetailState get initialState => TempatDetailInitial();

  @override
  Stream<TempatDetailState> mapEventToState(
    TempatDetailEvent event,
  ) async* {
    if (event is GetTempatDetail) {
      yield TempatDetailLoading();
      try {
        tempatDetailModel = await tempatDetailRepo.getTempatDetail(event.id);
        if (tempatDetailModel.status) {
          yield TempatDetailLoaded(tempatDetailModel: tempatDetailModel);
        } else {
          yield TempatDetailError('no_data');
        }
      } catch (e) {
        yield TempatDetailException('error');
      }
    }
  }
}
