import 'package:bloc/bloc.dart';
import 'package:desa_wisata_nusantara/feature/akun/domain/repo/akun_repo.dart';
import 'package:desa_wisata_nusantara/feature/akun/model/akun_model.dart';
import 'package:desa_wisata_nusantara/feature/akun/model/logout_model.dart';
import 'package:flutter/material.dart';
import 'bloc.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc({@required this.akunRepo})
      : assert(akunRepo != null),
        super(LogoutInitial());

  LogoutModel logoutModel;
  final AkunRepo akunRepo;

  LogoutState get initialState => LogoutInitial();

  @override
  Stream<LogoutState> mapEventToState(
    LogoutEvent event,
  ) async* {
    if (event is AttemptLogout) {
      yield LogoutLoading();
      try {
        logoutModel = await akunRepo.attemptLogout();
        if (logoutModel.status) {
          yield LogoutLoaded(logoutModel: logoutModel);
        } else {
          yield LogoutError('no_data');
        }
      } catch (e) {
        yield LogoutException('error');
      }
    }
  }
}
