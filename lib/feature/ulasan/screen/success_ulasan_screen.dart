import 'package:desa_wisata_nusantara/resources/color_swatch.dart';
import 'package:desa_wisata_nusantara/resources/route_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessUlasan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.checkmark_seal_fill,
                color: Colors.green, size: 60),
            SizedBox(height: 16),
            Center(
              child: Text('Terima Kasih untuk Ulasan Anda!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 32,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 16),
            Center(
              child: Text('Mohon menunggu, ulasan Anda akan segera muncul',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black,
                  )),
            ),
            SizedBox(height: 32),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      primaryColor,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ))),
                child: Text('Kembali ke Beranda',
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, bottomRoute, (route) => false);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
