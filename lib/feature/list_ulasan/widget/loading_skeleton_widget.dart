import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingSkeletonUlasan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 36.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                width: 100,
                height: 25,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 8),
          Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                width: double.infinity,
                height: 15,
                color: Colors.white,
              )),
          SizedBox(height: 4),
          Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                width: double.infinity,
                height: 15,
                color: Colors.white,
              )),
          SizedBox(height: 8),
          Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                width: double.infinity,
                height: 35,
                color: Colors.white,
              )),
          SizedBox(height: 16),
          Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                width: double.infinity,
                height: 15,
                color: Colors.white,
              )),
          SizedBox(height: 12),
          Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                width: double.infinity,
                height: 15,
                color: Colors.white,
              )),
          SizedBox(height: 8),
          Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                width: double.infinity,
                height: 65,
                color: Colors.white,
              )),
          Padding(
            padding: const EdgeInsets.only(top: 45.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                width: 100,
                height: 25,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 8),
          Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                width: double.infinity,
                height: 15,
                color: Colors.white,
              )),
          SizedBox(height: 4),
          Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                width: double.infinity,
                height: 15,
                color: Colors.white,
              )),
          SizedBox(height: 8),
          Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                width: double.infinity,
                height: 35,
                color: Colors.white,
              )),
          SizedBox(height: 16),
          Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                width: double.infinity,
                height: 15,
                color: Colors.white,
              )),
          SizedBox(height: 12),
          Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                width: double.infinity,
                height: 15,
                color: Colors.white,
              )),
          SizedBox(height: 8),
          Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                width: double.infinity,
                height: 65,
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}
