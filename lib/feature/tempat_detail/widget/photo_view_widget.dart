import 'package:desa_wisata_nusantara/feature/tempat_detail/model/tempat_detail_model.dart';
import 'package:desa_wisata_nusantara/resources/color_swatch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewWidget extends StatefulWidget {
  final List<Photos> photos;

  const PhotoViewWidget(this.photos);

  @override
  _PhotoViewWidgetState createState() => _PhotoViewWidgetState();
}

class _PhotoViewWidgetState extends State<PhotoViewWidget> {
  PageController pageController;
  int currentIndex = 0;
  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Stack(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    PhotoViewGallery.builder(
                      scrollPhysics: const BouncingScrollPhysics(),
                      builder: (BuildContext context, int index) {
                        return PhotoViewGalleryPageOptions(
                          imageProvider:
                              NetworkImage(widget.photos[index].sourceImage),
                          initialScale: PhotoViewComputedScale.contained * 0.8,
                          minScale: PhotoViewComputedScale.contained * 0.8,
                          maxScale: PhotoViewComputedScale.covered * 1.1,
                        );
                      },
                      itemCount: widget.photos.length,
                      loadingBuilder: (context, progress) => Center(
                        child: Container(
                          width: 20.0,
                          height: 20.0,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      backgroundDecoration: BoxDecoration(
                        color: Colors.black,
                      ),
                      pageController: pageController,
                      onPageChanged: onPageChanged,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "${widget.photos[currentIndex].description}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                          decoration: null,
                        ),
                      ),
                    )
                  ],
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.22,
                  left: 0.0,
                  right: 0.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: map<Widget>(widget.photos, (index, url) {
                      return Container(
                        width: 12.0,
                        height: 12.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentIndex == index
                              ? primaryColor
                              : Colors.white70,
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 30.0,
              left: 12.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Icon(
                        CupertinoIcons.arrow_left,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
