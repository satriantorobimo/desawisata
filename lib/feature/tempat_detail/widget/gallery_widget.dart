import 'package:desa_wisata_nusantara/feature/tempat_detail/widget/photo_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/model/tempat_detail_model.dart';

class GalleryWidget extends StatefulWidget {
  final List<Photos> photos;

  const GalleryWidget(this.photos);
  @override
  _GalleryWidgetState createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
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
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Gallery',
                  style: GoogleFonts.poppins(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                itemCount: widget.photos.length,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        List<Photos> photos = [];
                        photos.add(widget.photos[index]);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PhotoViewWidget(photos),
                            ));
                      },
                      child: Image.network(widget.photos[index].sourceImage));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
