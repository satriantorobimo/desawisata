import 'package:desa_wisata_nusantara/feature/akun/screen/akun_screen.dart';
import 'package:desa_wisata_nusantara/feature/home/screen/home_screen.dart';
import 'package:desa_wisata_nusantara/feature/list_ulasan/screen/list_ulasan_screen.dart';
import 'package:desa_wisata_nusantara/feature/search/screen/search_screen.dart';
import 'package:desa_wisata_nusantara/resources/color_swatch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigationV2Screen extends StatefulWidget {
  @override
  _BottomNavigationV2ScreenState createState() =>
      _BottomNavigationV2ScreenState();
}

class _BottomNavigationV2ScreenState extends State<BottomNavigationV2Screen> {
  int _selectedTabIndex = 0;
  final _bottomNavBarItem = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home, size: 24),
      label: 'Home',
    ),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search, size: 24), label: 'Search'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.bubble_middle_bottom, size: 24),
        label: 'Ulasan'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.person, size: 24), label: 'Akun'),
  ];

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  Widget getPage(int index) {
    if (index == 0) {
      return HomeScreen();
    }
    if (index == 1) {
      return SearchScreen();
    }

    if (index == 2) {
      return ListUlasanScreen();
    }

    if (index == 3) {
      return AkunScreen();
    }

    return HomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
              activeColor: primaryColor,
              inactiveColor: Colors.grey,
              backgroundColor: Colors.white,
              items: _bottomNavBarItem,
              currentIndex: _selectedTabIndex,
              onTap: _onNavBarTapped),
          tabBuilder: (BuildContext context, int index) {
            return CupertinoTabView(
              builder: (BuildContext context) {
                return SafeArea(
                  top: false,
                  bottom: false,
                  child: CupertinoApp(
                    home: CupertinoPageScaffold(
                      resizeToAvoidBottomInset: false,
                      child: getPage(_selectedTabIndex),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
