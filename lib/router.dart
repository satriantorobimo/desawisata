import 'package:desa_wisata_nusantara/feature/akun/screen/akun_screen.dart';
import 'package:desa_wisata_nusantara/feature/akun/widget/pnp_widget.dart';
import 'package:desa_wisata_nusantara/feature/bottom_navigation/screen/bottom_navigation_screen.dart';
import 'package:desa_wisata_nusantara/feature/bottom_navigation/screen/bottom_navigation_v2_screen.dart';
import 'package:desa_wisata_nusantara/feature/desa_detail/screen/desa_detail_screen.dart';
import 'package:desa_wisata_nusantara/feature/home/widget/category_menu_widget.dart';
import 'package:desa_wisata_nusantara/feature/intro/screen/intro_screen.dart';
import 'package:desa_wisata_nusantara/feature/list_category/screen/list_category_screen.dart';
import 'package:desa_wisata_nusantara/feature/list_desa/screen/list_desa_screen.dart';
import 'package:desa_wisata_nusantara/feature/login/screen/login_screen.dart';
import 'package:desa_wisata_nusantara/feature/lupa_password/screen/lupa_password_screen.dart';
import 'package:desa_wisata_nusantara/feature/onboard/screen/onboard_screen.dart';
import 'package:desa_wisata_nusantara/feature/search/screen/search_screen.dart';
import 'package:desa_wisata_nusantara/feature/signup/screen/signup_screen.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/model/tempat_detail_model.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/screen/tempat_detail_screen.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/widget/fasilitas_widget.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/widget/jam_buka_widget.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/widget/success_pertanyaan_screen.dart';
import 'package:desa_wisata_nusantara/feature/ulasan/model/argument_ulasan_model.dart';
import 'package:desa_wisata_nusantara/feature/ulasan/screen/success_ulasan_screen.dart';
import 'package:desa_wisata_nusantara/feature/ulasan/screen/ulasan_screen.dart';
import 'package:desa_wisata_nusantara/feature/ulasan/widget/tulis_judul_ulasan_widget.dart';
import 'package:desa_wisata_nusantara/feature/ulasan/widget/tulis_ulasan_widget.dart';
import 'package:desa_wisata_nusantara/feature/ulasan/widget/ulasan_tambahan_widget.dart';

import 'package:flutter/material.dart';
import 'package:desa_wisata_nusantara/feature/home/model/per_kab_model.dart'
    as perkab;
import 'package:desa_wisata_nusantara/feature/home/model/category_home_model.dart'
    as category;
import 'feature/home/screen/home_screen.dart';
import 'feature/splash/screen/splash_screen.dart';
import 'resources/route_string.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => SplashScreen(),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case homeRoute:
        // final LoginModel loginModel = settings.arguments as LoginModel;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => HomeScreen(),
            settings: RouteSettings(name: settings.name),
            reverseTransitionDuration: Duration(milliseconds: 180),
            transitionDuration: Duration(milliseconds: 180),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                SlideTransition(
                  position:
                      Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                          .animate(a),
                  child: c,
                ));

      case akunRoute:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => AkunScreen(),
            settings: RouteSettings(name: settings.name),
            reverseTransitionDuration: Duration(milliseconds: 180),
            transitionDuration: Duration(milliseconds: 180),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                SlideTransition(
                  position:
                      Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                          .animate(a),
                  child: c,
                ));

      case bottomRoute:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => BottomNavigationScreen(),
            settings: RouteSettings(name: settings.name),
            reverseTransitionDuration: Duration(milliseconds: 180),
            transitionDuration: Duration(milliseconds: 180),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                SlideTransition(
                  position:
                      Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                          .animate(a),
                  child: c,
                ));

      case bottomV2Route:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => BottomNavigationV2Screen(),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case loginRoute:
        final bool isFromDaftar = settings.arguments;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => LoginScreen(isFromDaftar),
            settings: RouteSettings(name: settings.name),
            reverseTransitionDuration: Duration(milliseconds: 180),
            transitionDuration: Duration(milliseconds: 180),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                SlideTransition(
                  position:
                      Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                          .animate(a),
                  child: c,
                ));

      case searchRoute:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => SearchScreen(),
            settings: RouteSettings(name: settings.name),
            reverseTransitionDuration: Duration(milliseconds: 180),
            transitionDuration: Duration(milliseconds: 180),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                SlideTransition(
                  position:
                      Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                          .animate(a),
                  child: c,
                ));

      case signupRoute:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => SignUpScreen(),
            settings: RouteSettings(name: settings.name),
            reverseTransitionDuration: Duration(milliseconds: 180),
            transitionDuration: Duration(milliseconds: 180),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                SlideTransition(
                  position:
                      Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                          .animate(a),
                  child: c,
                ));

      case ulasanRoute:
        final ArgumentUlasanModel argumentUlasanModel =
            settings.arguments as ArgumentUlasanModel;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => UlasanScreen(argumentUlasanModel),
            settings: RouteSettings(name: settings.name),
            reverseTransitionDuration: Duration(milliseconds: 180),
            transitionDuration: Duration(milliseconds: 180),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                SlideTransition(
                  position:
                      Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                          .animate(a),
                  child: c,
                ));

      case introRoute:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => IntroScreen(),
            settings: RouteSettings(name: settings.name),
            reverseTransitionDuration: Duration(milliseconds: 180),
            transitionDuration: Duration(milliseconds: 180),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                SlideTransition(
                  position:
                      Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                          .animate(a),
                  child: c,
                ));

      case tempatDetailRoute:
        final String id = settings.arguments;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => TempatDetailScreen(id),
            settings: RouteSettings(name: settings.name),
            reverseTransitionDuration: Duration(milliseconds: 180),
            transitionDuration: Duration(milliseconds: 180),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                SlideTransition(
                  position:
                      Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                          .animate(a),
                  child: c,
                ));

      case desaDetailRoute:
        final String id = settings.arguments;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => DesaDetailScreen(id),
            settings: RouteSettings(name: settings.name),
            reverseTransitionDuration: Duration(milliseconds: 180),
            transitionDuration: Duration(milliseconds: 180),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                SlideTransition(
                  position:
                      Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                          .animate(a),
                  child: c,
                ));

      case listDesaRoute:
        final perkab.Data perkabData = settings.arguments as perkab.Data;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => ListDesaScreen(perkabData),
            settings: RouteSettings(name: settings.name),
            reverseTransitionDuration: Duration(milliseconds: 180),
            transitionDuration: Duration(milliseconds: 180),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                SlideTransition(
                  position:
                      Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                          .animate(a),
                  child: c,
                ));

      case onboardRoute:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => OnboardScreen(),
            settings: RouteSettings(name: settings.name),
            reverseTransitionDuration: Duration(milliseconds: 180),
            transitionDuration: Duration(milliseconds: 180),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                SlideTransition(
                  position:
                      Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                          .animate(a),
                  child: c,
                ));

      case lupaPasswordRoute:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => LupaPasswordScreen(),
            settings: RouteSettings(name: settings.name),
            reverseTransitionDuration: Duration(milliseconds: 180),
            transitionDuration: Duration(milliseconds: 180),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                SlideTransition(
                  position:
                      Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                          .animate(a),
                  child: c,
                ));

      case tulisUlasanRoute:
        final String values = settings.arguments;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => TulisUlasanWidget(values),
            settings: RouteSettings(name: settings.name),
            reverseTransitionDuration: Duration(milliseconds: 180),
            transitionDuration: Duration(milliseconds: 180),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                SlideTransition(
                  position:
                      Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                          .animate(a),
                  child: c,
                ));

      case tulisJudulUlasanRoute:
        final String values = settings.arguments;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => TulisJudulUlasanWidget(values),
            settings: RouteSettings(name: settings.name),
            reverseTransitionDuration: Duration(milliseconds: 180),
            transitionDuration: Duration(milliseconds: 180),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                SlideTransition(
                  position:
                      Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                          .animate(a),
                  child: c,
                ));

      case ulasanTambahanRoute:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => UlasanTambahanWidget(),
            settings: RouteSettings(name: settings.name),
            reverseTransitionDuration: Duration(milliseconds: 180),
            transitionDuration: Duration(milliseconds: 180),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                SlideTransition(
                  position:
                      Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                          .animate(a),
                  child: c,
                ));

      case jamBukaRoute:
        final List<Hours> jamBuka = settings.arguments as List<Hours>;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => JamBukaWidget(jamBuka),
            settings: RouteSettings(name: settings.name),
            reverseTransitionDuration: Duration(milliseconds: 180),
            transitionDuration: Duration(milliseconds: 180),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                SlideTransition(
                  position:
                      Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                          .animate(a),
                  child: c,
                ));

      case categoryMenuRoute:
        final List<category.Data> categories =
            settings.arguments as List<category.Data>;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => CategoryMenuWidget(categories),
            settings: RouteSettings(name: settings.name),
            reverseTransitionDuration: Duration(milliseconds: 180),
            transitionDuration: Duration(milliseconds: 180),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                SlideTransition(
                  position:
                      Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                          .animate(a),
                  child: c,
                ));

      case successUlasanRoute:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => SuccessUlasan(),
            settings: RouteSettings(name: settings.name),
            reverseTransitionDuration: Duration(milliseconds: 180),
            transitionDuration: Duration(milliseconds: 180),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                SlideTransition(
                  position:
                      Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                          .animate(a),
                  child: c,
                ));

      case successPertanyaanRoute:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => SuccessPertanyaan(),
            settings: RouteSettings(name: settings.name),
            reverseTransitionDuration: Duration(milliseconds: 180),
            transitionDuration: Duration(milliseconds: 180),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                SlideTransition(
                  position:
                      Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                          .animate(a),
                  child: c,
                ));

      case semuaFasilitasRoute:
        final String fasilitas = settings.arguments;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => FasilitasWidget(fasilitas),
            settings: RouteSettings(name: settings.name),
            reverseTransitionDuration: Duration(milliseconds: 180),
            transitionDuration: Duration(milliseconds: 180),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                SlideTransition(
                  position:
                      Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                          .animate(a),
                  child: c,
                ));

      case pnpRouter:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => PnpWidget(),
            settings: RouteSettings(name: settings.name),
            reverseTransitionDuration: Duration(milliseconds: 180),
            transitionDuration: Duration(milliseconds: 180),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                SlideTransition(
                  position:
                      Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                          .animate(a),
                  child: c,
                ));

      case listCategoryRoute:
        final category.Data categories = settings.arguments as category.Data;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => ListCategoryScreen(categories),
            settings: RouteSettings(name: settings.name),
            reverseTransitionDuration: Duration(milliseconds: 180),
            transitionDuration: Duration(milliseconds: 180),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                SlideTransition(
                  position:
                      Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                          .animate(a),
                  child: c,
                ));

      default:
        return MaterialPageRoute<dynamic>(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
