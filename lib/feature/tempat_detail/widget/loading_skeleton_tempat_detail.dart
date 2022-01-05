import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingSkeletonTempatDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.40,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                child: Container(
                  width: 100,
                  height: 25,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                child: Container(
                  width: 200,
                  height: 15,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                child: Container(
                  width: 120,
                  height: 15,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                child: Container(
                  width: 100,
                  height: 23,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 13),
              Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                child: Container(
                  width: double.infinity,
                  height: 15,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                child: Container(
                  width: double.infinity,
                  height: 15,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                child: Container(
                  width: double.infinity,
                  height: 15,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 32),
              Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                child: Container(
                  width: double.infinity,
                  height: 55,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 24),
              Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                child: Container(
                  width: double.infinity,
                  height: 150,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
