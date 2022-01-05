import 'package:desa_wisata_nusantara/feature/tempat_detail/model/tempat_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JamBukaWidget extends StatelessWidget {
  final List<Hours> jamBuka;

  const JamBukaWidget(this.jamBuka);

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
              Text('Jam Buka',
                  style: GoogleFonts.poppins(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 16,
                    );
                  },
                  itemCount: jamBuka.length,
                  reverse: false,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${jamBuka[index].day}',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          Text(jamBuka[index].hour ?? 'Tutup',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.black,
                              )),
                        ]);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
