import 'package:desa_wisata_nusantara/feature/akun/screen/akun_screen.dart';
import 'package:desa_wisata_nusantara/feature/home/screen/home_screen.dart';
import 'package:desa_wisata_nusantara/feature/list_ulasan/screen/list_ulasan_screen.dart';
import 'package:desa_wisata_nusantara/feature/search/screen/search_screen.dart';
import 'package:desa_wisata_nusantara/feature/ulasan/screen/ulasan_screen.dart';
import 'package:desa_wisata_nusantara/resources/color_swatch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigationScreen extends StatefulWidget {
  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              items: _bottomNavBarItem,
              currentIndex: _selectedTabIndex,
              selectedItemColor: primaryColor,
              unselectedItemColor: Colors.grey,
              onTap: _onNavBarTapped),
          body: getPage(_selectedTabIndex)),
    );
  }
}
