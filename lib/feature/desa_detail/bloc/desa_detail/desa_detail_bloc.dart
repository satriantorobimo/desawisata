import 'package:bloc/bloc.dart';
import 'package:desa_wisata_nusantara/feature/desa_detail/domain/repo/desa_detail_repo.dart';
import 'package:desa_wisata_nusantara/feature/desa_detail/model/desa_detail_model.dart';
import 'package:flutter/material.dart';
import 'bloc.dart';

class DesaDetailBloc extends Bloc<DesaDetailEvent, DesaDetailState> {
  DesaDetailBloc({@required this.desaDetailRepo})
      : assert(desaDetailRepo != null),
        super(DesaDetailInitial());

  DesaDetailModel desaDetailModel;
  final DesaDetailRepo desaDetailRepo;

  DesaDetailState get initialState => DesaDetailInitial();

  @override
  Stream<DesaDetailState> mapEventToState(
    DesaDetailEvent event,
  ) async* {
    if (event is GetDesaDetailValue) {
      yield DesaDetailLoading();
      try {
        desaDetailModel = await desaDetailRepo.getDetailDesa(event.id);
        if (desaDetailModel.status) {
          yield DesaDetailLoaded(desaDetailModel: desaDetailModel);
        } else {
          yield DesaDetailError('no_data');
        }
      } catch (e) {
        yield DesaDetailException('error');
      }
    }
  }
}
