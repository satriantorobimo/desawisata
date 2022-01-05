import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingSkeletonListDesa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemCount: 3,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 10,
          );
        },
        reverse: false,
        itemBuilder: (BuildContext context, int index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Container(
                width: double.infinity,
                height: 165.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                )),
          );
        });
  }
}
