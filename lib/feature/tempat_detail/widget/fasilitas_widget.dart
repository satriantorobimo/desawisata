import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FasilitasWidget extends StatelessWidget {
  final String fasilitas;

  const FasilitasWidget(this.fasilitas);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 24.0, right: 24.0),
              child: Icon(
                Icons.close,
                color: Colors.black,
                size: 20,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Fasilitas',
                  style: GoogleFonts.poppins(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              Text(fasilitas,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.black,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
