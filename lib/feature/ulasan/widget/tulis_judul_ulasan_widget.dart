import 'dart:developer';

import 'package:desa_wisata_nusantara/resources/color_swatch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TulisJudulUlasanWidget extends StatefulWidget {
  const TulisJudulUlasanWidget(this.values);
  final String values;

  @override
  _TulisJudulUlasanWidgetState createState() => _TulisJudulUlasanWidgetState();
}

class _TulisJudulUlasanWidgetState extends State<TulisJudulUlasanWidget> {
  TextEditingController _reviewCtrl = TextEditingController();
  int _lengthText = 0;

  @override
  void initState() {
    if (widget.values != '') {
      setState(() {
        _reviewCtrl.text = widget.values;
        _lengthText = widget.values.length;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, _reviewCtrl.text);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 40.0, bottom: 16.0),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Judul Ulasan',
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 16.0),
                    TextField(
                      maxLines: 8,
                      controller: _reviewCtrl,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(120),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _lengthText = value.length;
                        });
                      },
                      decoration: InputDecoration.collapsed(
                          hintText:
                              'Ringkaskan kunjungan Anda dengan beberapa kata',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey,
                          )),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('$_lengthText/120 maksimal karakter',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black,
                        )),
                    Container(
                      height: 40,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              primaryColor,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ))),
                        child: Text('Selesai',
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          log('${_reviewCtrl.text}');
                          Navigator.pop(context, _reviewCtrl.text);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
