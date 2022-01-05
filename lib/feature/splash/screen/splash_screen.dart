import 'dart:developer';

import 'package:desa_wisata_nusantara/feature/splash/bloc/refresh/bloc.dart';
import 'package:desa_wisata_nusantara/feature/splash/domain/repo/refresh_repo.dart';
import 'package:desa_wisata_nusantara/resources/color_swatch.dart';
import 'package:desa_wisata_nusantara/resources/route_string.dart';
import 'package:desa_wisata_nusantara/util/general_util.dart';
import 'package:desa_wisata_nusantara/util/shared_preff.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:device_information/device_information.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  RefreshBloc refreshBloc = RefreshBloc(refreshRepo: RefreshRepo());

  @override
  void dispose() {
    refreshBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    _initImei();
    super.initState();
  }

  Future<PermissionStatus> _getPhonePermission() async {
    final PermissionStatus permission = await Permission.phone.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.phone].request();
      return permissionStatus[Permission.phone] ??
          PermissionStatus.undetermined;
    } else {
      return permission;
    }
  }

  Future<void> _initImei() async {
    String _imei;
    try {
      final PermissionStatus permissionStatus = await _getPhonePermission();
      if (permissionStatus.isGranted) {
        _imei = await DeviceInformation.deviceIMEINumber;
        print('imei: $_imei');
        SharedPreff().savedSharedString('imei', _imei);
        log('${GeneralUtil().encryptAES(_imei)}');
      }
    } on PlatformException {
      _imei = 'IMEI Device not Found';
    }
    if (!mounted) return;
    SharedPreff().getSharedString('token').then((value) {
      log('$value');
      if (value != null) {
        refreshBloc.add(AttemptRefresh());
      } else {
        SharedPreff().getSharedBool('intro').then((value) {
          log('$value');
          if (value != null) {
            if (value) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                bottomRoute,
                (route) => false,
              );
            } else {
              Navigator.pushNamedAndRemoveUntil(
                  context, introRoute, (route) => false);
            }
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, introRoute, (route) => false);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<RefreshBloc, RefreshState>(
          cubit: refreshBloc,
          listener: (_, RefreshState state) {
            if (state is RefreshLoaded) {
              SharedPreff()
                  .savedSharedString('token', state.refreshModel.accessToken);
              Navigator.pushNamedAndRemoveUntil(
                  context, bottomRoute, (route) => false);
            }
            if (state is RefreshError) {
              Navigator.pushNamedAndRemoveUntil(
                  context, loginRoute, (route) => false,
                  arguments: true);
            }
          },
          child: BlocBuilder<RefreshBloc, RefreshState>(
              cubit: refreshBloc,
              builder: (_, RefreshState state) {
                if (state is RefreshInitial) {
                  return mainContent(context);
                }
                if (state is RefreshLoading) {
                  return mainContent(context);
                }
                if (state is RefreshLoaded) {
                  return mainContent(context);
                }
                if (state is RefreshError) {
                  return mainContent(context);
                }
                return mainContent(context);
              })),
    );
  }

  Widget mainContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logo.png',
          width: MediaQuery.of(context).size.width * 0.45,
          height: MediaQuery.of(context).size.width * 0.45,
        ),
        SizedBox(height: 16),
        Center(
          child: Text(
            'Desa Wisata',
            style: GoogleFonts.ptSans(
                color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        Center(
          child: Text(
            'Mari bersama membangun desa',
            style: GoogleFonts.ptSans(
              color: Colors.black,
              fontSize: 12,
            ),
          ),
        ),
        SizedBox(height: 32),
        Container(
          width: 32,
          height: 32,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
          ),
        )
      ],
    );
  }
}
