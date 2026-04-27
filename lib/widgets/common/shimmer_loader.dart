import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  final int count;
  final double height;
  const ShimmerLoader({
    super.key,
    required this.count,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: count,
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (context, _) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}

class ShimmerLoaderHorizontal extends StatelessWidget {
  final int count;
  final double height;
  final double width;
  const ShimmerLoaderHorizontal({
    super.key,
    required this.count,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: count,
      scrollDirection: Axis.horizontal,
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (context, _) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
