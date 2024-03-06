import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final Widget shimmerChild;
  const ShimmerLoading({super.key, required this.isLoading, required this.child, required this.shimmerChild});

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return child;
    }
    return Shimmer.fromColors(
      baseColor: Colors.grey[350]!,
      highlightColor: Colors.grey[200]!,
      child: shimmerChild,
    );
  }
}
