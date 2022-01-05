import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingSkeletonSmall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Container(
            width: 291.0,
            height: 180.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: Colors.white,
            )),
      ),
    );
  }
}
