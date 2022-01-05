import 'package:desa_wisata_nusantara/util/dynamic_link_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'resources/color_swatch.dart';
import 'resources/route_string.dart';
import 'router.dart';
import 'util/navigation_service.dart';
import 'util/setup_locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DynamicLinkService _dynamicLinkService = DynamicLinkService();

  @override
  void initState() {
    _dynamicLinkService.initDynamicLinks(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desa Wisata Nusantara',
      theme: ThemeData(
        primaryColor: primaryColor,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      onGenerateRoute: Routers.generateRoute,
      initialRoute: splashRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
