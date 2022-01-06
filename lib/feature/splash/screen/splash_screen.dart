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
    SharedPreff().savedSharedBool('intro', true);
    super.dispose();
  }

  @override
  void initState() {
    GeneralUtil().getDeviceDetails().then((value) => {
          log('$value'),
          SharedPreff().savedSharedString('imei', value),
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
          })
        });

    super.initState();
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
              SharedPreff().deleteSharedPref('token');
              Navigator.pushNamedAndRemoveUntil(
                context,
                bottomRoute,
                (route) => false,
              );
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
