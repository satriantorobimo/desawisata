import 'package:bloc/bloc.dart';
import 'package:desa_wisata_nusantara/feature/splash/domain/repo/refresh_repo.dart';
import 'package:desa_wisata_nusantara/feature/splash/model/refresh_model.dart';
import 'package:flutter/material.dart';
import 'bloc.dart';

class RefreshBloc extends Bloc<RefreshEvent, RefreshState> {
  RefreshBloc({@required this.refreshRepo})
      : assert(refreshRepo != null),
        super(RefreshInitial());

  RefreshModel refreshModel;
  final RefreshRepo refreshRepo;

  RefreshState get initialState => RefreshInitial();

  @override
  Stream<RefreshState> mapEventToState(
    RefreshEvent event,
  ) async* {
    if (event is AttemptRefresh) {
      yield RefreshLoading();
      try {
        refreshModel = await refreshRepo.attemptRefresh();
        if (refreshModel.status) {
          yield RefreshLoaded(refreshModel: refreshModel);
        } else {
          yield RefreshError('error');
        }
      } catch (e) {
        yield RefreshError('error');
      }
    }
  }
}
