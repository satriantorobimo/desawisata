import 'package:bloc/bloc.dart';
import 'package:desa_wisata_nusantara/feature/akun/domain/repo/akun_repo.dart';
import 'package:desa_wisata_nusantara/feature/akun/model/akun_model.dart';
import 'package:flutter/material.dart';
import 'bloc.dart';

class AkunBloc extends Bloc<AkunEvent, AkunState> {
  AkunBloc({@required this.akunRepo})
      : assert(akunRepo != null),
        super(AkunInitial());

  AkunModel akunModel;
  final AkunRepo akunRepo;

  AkunState get initialState => AkunInitial();

  @override
  Stream<AkunState> mapEventToState(
    AkunEvent event,
  ) async* {
    if (event is GetAkun) {
      yield AkunLoading();
      try {
        akunModel = await akunRepo.getAkun();
        if (akunModel.status) {
          yield AkunLoaded(akunModel: akunModel);
        } else {
          yield AkunError('no_data');
        }
      } catch (e) {
        yield AkunException('error');
      }
    }
  }
}
