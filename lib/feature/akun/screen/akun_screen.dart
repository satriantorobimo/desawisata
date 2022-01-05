import 'package:desa_wisata_nusantara/feature/akun/bloc/akun/bloc.dart';
import 'package:desa_wisata_nusantara/feature/akun/bloc/logout/bloc.dart';
import 'package:desa_wisata_nusantara/feature/akun/domain/repo/akun_repo.dart';
import 'package:desa_wisata_nusantara/feature/akun/model/akun_model.dart';
import 'package:desa_wisata_nusantara/feature/akun/widget/loading_skeleton_widget.dart';
import 'package:desa_wisata_nusantara/resources/color_swatch.dart';
import 'package:desa_wisata_nusantara/resources/route_string.dart';
import 'package:desa_wisata_nusantara/util/shared_preff.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info/package_info.dart';

class AkunScreen extends StatefulWidget {
  @override
  _AkunScreenState createState() => _AkunScreenState();
}

class _AkunScreenState extends State<AkunScreen> {
  AkunBloc akunBloc = AkunBloc(akunRepo: AkunRepo());
  LogoutBloc logoutBloc = LogoutBloc(akunRepo: AkunRepo());
  String version = '', buildNumber = '';
  bool isEligible = false;

  @override
  void initState() {
    SharedPreff().getSharedString('token').then((value) {
      if (value != null) {
        akunBloc.add(GetAkun());
        setState(() {
          isEligible = true;
        });
      }
    });

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        version = packageInfo.version;
        buildNumber = packageInfo.buildNumber;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    akunBloc.close();
    logoutBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: !isEligible
            ? contentMethodNotEligible()
            : SingleChildScrollView(
                child: BlocListener<AkunBloc, AkunState>(
                cubit: akunBloc,
                listener: (_, AkunState state) {
                  if (state is AkunLoaded) {}
                  if (state is AkunError) {}
                },
                child: BlocBuilder<AkunBloc, AkunState>(
                    cubit: akunBloc,
                    builder: (_, AkunState state) {
                      if (state is AkunInitial) {
                        return LoadingSkeletonAkun();
                      }
                      if (state is AkunLoading) {
                        return LoadingSkeletonAkun();
                      }
                      if (state is AkunLoaded) {
                        return contentMethod(state.akunModel);
                      }
                      if (state is AkunError) {
                        return Container();
                      }
                      return Container();
                    }),
              )));
  }

  Widget contentMethodNotEligible() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              Text('Akun',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 24),
              Center(
                child: Image.asset('assets/images/tuyul.png',
                    width: MediaQuery.of(context).size.width * 0.25),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 20,
          color: Colors.grey.withOpacity(0.3),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Text('Tentang Aplikasi',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Privacy policy',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 18,
                  )
                ],
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 20,
          color: Colors.grey.withOpacity(0.3),
        ),
        btnLoginMethod(),
        Center(
          child: Text('Versi aplikasi $version $buildNumber',
              style: GoogleFonts.poppins(color: Colors.black, fontSize: 12)),
        ),
      ],
    );
  }

  Widget btnLoginMethod() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        height: 50,
        child: OutlinedButton(
          onPressed: () {
            Navigator.pushNamed(context, loginRoute, arguments: false);
          },
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
              side: BorderSide(width: 1, color: primaryColor)),
          child: Text('Masuk',
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor)),
        ),
      ),
    );
  }

  Widget contentMethod(AkunModel akunModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              Text('Akun',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 24),

              Center(
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(akunModel.data.sourceImage),
                  backgroundColor: Colors.transparent,
                ),
              ),

              SizedBox(height: 16),
              Center(
                child: Text('${akunModel.data.name}',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ),
              Center(
                child: Text('${akunModel.data.email}',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14,
                    )),
              ),
              // SizedBox(height: 16),
              // Container(
              //   width: double.infinity,
              //   height: 50,
              //   child: ElevatedButton(
              //     style: ButtonStyle(
              //         foregroundColor:
              //             MaterialStateProperty.all<Color>(Colors.white),
              //         backgroundColor: MaterialStateProperty.all<Color>(
              //           primaryColor,
              //         ),
              //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //             RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(24.0),
              //         ))),
              //     child: Text('Atur Akun',
              //         style: GoogleFonts.poppins(
              //             fontSize: 14, fontWeight: FontWeight.bold)),
              //     onPressed: () {},
              //   ),
              // ),
              SizedBox(height: 8),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 20,
          color: Colors.grey.withOpacity(0.3),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Text('Tentang Aplikasi',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, pnpRouter);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Privacy policy',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 18,
                    )
                  ],
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 20,
          color: Colors.grey.withOpacity(0.3),
        ),
        BlocListener<LogoutBloc, LogoutState>(
          cubit: logoutBloc,
          listener: (_, LogoutState state) {
            if (state is LogoutLoaded) {
              SharedPreff().clearSharedPref();
              Navigator.pushNamedAndRemoveUntil(
                  context, loginRoute, (route) => false,
                  arguments: true);
            }
            if (state is LogoutError) {}
          },
          child: BlocBuilder<LogoutBloc, LogoutState>(
              cubit: logoutBloc,
              builder: (_, LogoutState state) {
                if (state is LogoutInitial) {
                  return btnLogoutMethod();
                }
                if (state is LogoutLoading) {
                  return btnLogoutMethod();
                }
                if (state is LogoutLoaded) {
                  return btnLogoutMethod();
                }
                if (state is LogoutError) {
                  return btnLogoutMethod();
                }
                return btnLogoutMethod();
              }),
        ),
        Center(
          child: Text('Versi aplikasi $version $buildNumber',
              style: GoogleFonts.poppins(color: Colors.black, fontSize: 12)),
        ),
      ],
    );
  }

  Widget btnLogoutMethod() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        height: 50,
        child: OutlinedButton(
          onPressed: () {
            logoutBloc.add(AttemptLogout());
          },
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
              side: BorderSide(width: 1, color: primaryColor)),
          child: Text('Keluar',
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor)),
        ),
      ),
    );
  }
}
