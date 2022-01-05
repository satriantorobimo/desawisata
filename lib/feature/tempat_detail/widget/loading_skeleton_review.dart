import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingSkeletonReview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24),
        Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Container(
            width: double.infinity,
            height: 32,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 20),
        Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Container(
            width: double.infinity,
            height: 15,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16),
        Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Container(
            width: double.infinity,
            height: 35,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16),
        Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Container(
            width: double.infinity,
            height: 15,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
