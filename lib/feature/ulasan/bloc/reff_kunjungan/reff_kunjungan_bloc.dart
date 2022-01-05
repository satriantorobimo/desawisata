import 'package:bloc/bloc.dart';
import 'package:desa_wisata_nusantara/feature/ulasan/domain/repo/reff_kunjugan_repo.dart';
import 'package:desa_wisata_nusantara/feature/ulasan/model/reff_kunjugan_model.dart';
import 'package:flutter/material.dart';
import 'bloc.dart';

class ReffKunjunganBloc extends Bloc<ReffKunjunganEvent, ReffKunjunganState> {
  ReffKunjunganBloc({@required this.reffKunjunganRepo})
      : assert(reffKunjunganRepo != null),
        super(ReffKunjunganInitial());

  ReffKunjunganModel reffKunjunganModel;
  final ReffKunjunganRepo reffKunjunganRepo;

  ReffKunjunganState get initialState => ReffKunjunganInitial();

  @override
  Stream<ReffKunjunganState> mapEventToState(
    ReffKunjunganEvent event,
  ) async* {
    if (event is GetReffKunjungan) {
      yield ReffKunjunganLoading();
      try {
        reffKunjunganModel = await reffKunjunganRepo.getReffKunjungan();
        if (reffKunjunganModel.status) {
          yield ReffKunjunganLoaded(reffKunjunganModel: reffKunjunganModel);
        } else {
          yield ReffKunjunganError('no_data');
        }
      } catch (e) {
        yield ReffKunjunganException('error');
      }
    }
  }
}
