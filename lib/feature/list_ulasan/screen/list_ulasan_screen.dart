import 'package:desa_wisata_nusantara/feature/list_ulasan/widget/list_pertanyaan_widget.dart';
import 'package:desa_wisata_nusantara/feature/list_ulasan/widget/list_ulasan_widget.dart';

import 'package:desa_wisata_nusantara/resources/route_string.dart';
import 'package:desa_wisata_nusantara/util/shared_preff.dart';
import 'package:desa_wisata_nusantara/widget/custom_dialog_login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListUlasanScreen extends StatefulWidget {
  @override
  _ListUlasanWidgetState createState() => _ListUlasanWidgetState();
}

class _ListUlasanWidgetState extends State<ListUlasanScreen> {
  static final List<String> menuDetail = ['Ulasan', 'Tanya Jawab'];
  int _indexMenuDetail = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              Text('Ulasan',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 24),
              Container(
                width: double.infinity,
                height: 35,
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        width: 24,
                      );
                    },
                    itemCount: menuDetail.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _indexMenuDetail = index;
                          });
                        },
                        child: Column(
                          children: <Widget>[
                            FittedBox(
                              child: Container(
                                child: Stack(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        menuDetail[index],
                                        style: GoogleFonts.poppins(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    _indexMenuDetail == index
                                        ? Positioned.fill(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                SizedBox(height: 5),
                                                Container(
                                                  height: 4,
                                                  color: Colors.black,
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              _indexMenuDetail == 0
                  ? ListUlasanWidget()
                  : ListPertanyaanWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
