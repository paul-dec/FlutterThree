import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular({Key? key,
    this.width = double.infinity,
    required this.height,
  }) :shapeBorder = const RoundedRectangleBorder(), super(key: key);

  const ShimmerWidget.circular({Key? key,
    required this.width,
    required this.height,
    this.shapeBorder = const CircleBorder(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
    baseColor: Colors.pink[200]!,
    highlightColor: Colors.pink[100]!,
    child: Container(
      width: width,
      height: height,
      decoration: ShapeDecoration (
          color: Colors.pink[200]!,
          shape: shapeBorder
      ),
    ),
  );
}