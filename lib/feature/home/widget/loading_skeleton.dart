import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingSkeletonHiglight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.56,
        color: Colors.white,
      ),
    );
  }
}
