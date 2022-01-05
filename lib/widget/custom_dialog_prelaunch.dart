import 'package:desa_wisata_nusantara/resources/color_swatch.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDialogPrelaunch extends StatelessWidget {
  final String value;
  final bool isSuccess;
  final GestureTapCallback onTap;

  const CustomDialogPrelaunch({this.value, this.onTap, this.isSuccess});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context, value),
    );
  }

  Widget dialogContent(BuildContext context, String value) {
    return Container(
      margin: EdgeInsets.only(left: 0.0, right: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                isSuccess
                    ? Center(
                        child: Icon(CupertinoIcons.checkmark_seal,
                            color: Colors.green, size: 40))
                    : Center(
                        child: Icon(CupertinoIcons.xmark_shield,
                            color: Colors.red, size: 40)),
                SizedBox(
                  height: 16.0,
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(value,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.black)),
                ) //
                    ),
                SizedBox(height: 24.0),
                Container(
                  height: 40,
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: onTap,
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        side: BorderSide(width: 1, color: primaryColor)),
                    child: Text('Ok',
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor)),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            right: 8.0,
            top: 8.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.close, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
