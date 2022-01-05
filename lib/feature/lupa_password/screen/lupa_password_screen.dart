import 'package:desa_wisata_nusantara/resources/color_swatch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LupaPasswordScreen extends StatefulWidget {
  @override
  _LupaPasswordScreenState createState() => _LupaPasswordScreenState();
}

class _LupaPasswordScreenState extends State<LupaPasswordScreen> {
  TextEditingController _emailCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            CupertinoIcons.arrow_left,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Lupa Sandi',
                style: GoogleFonts.roboto(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 48),
            Container(
              margin: EdgeInsets.only(top: 12.5, bottom: 24),
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Center(
                  child: FormBuilderTextField(
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    name: 'email_form',
                    decoration: InputDecoration.collapsed(
                      hintText: "Alamat email",
                      hintStyle: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.black54),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 5,
                    spreadRadius: 1.5,
                    offset: const Offset(
                      0.0,
                      5.5,
                    ),
                  ),
                ],
              ),
            ),
            Text(
                'Masukkan alamat email yang digunakan saat mendaftar.Kami akan mengirimkan link untuk membuat ulang sandi',
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: Colors.black,
                )),
            SizedBox(height: 40),
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
                      borderRadius: BorderRadius.circular(24.0),
                    ))),
                child: Text('Kirim email',
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.bold)),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
