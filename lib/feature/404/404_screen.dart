import 'package:desa_wisata_nusantara/resources/color_swatch.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Error404Screen extends StatelessWidget {
  final GestureTapCallback onTap;
  Error404Screen({this.onTap});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Image.asset('assets/images/404.png'),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            'Oops, terjadi kesalahan pada system',
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            width: 250,
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
                    borderRadius: BorderRadius.circular(24.0),
                  ))),
              child: Text('Coba Lagi',
                  style: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.bold)),
              onPressed: onTap,
            ),
          ),
        ],
      ),
    );
  }
}
