import 'package:flutter/material.dart';

class CustomBoard extends StatelessWidget {
  const CustomBoard(
      {super.key,
      this.color,
      this.margin,
      this.width,
      this.height,
      this.crossAxisAlignment,
      required this.children});
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final List<Widget> children;
  final WrapCrossAlignment? crossAxisAlignment;
  @override
  Widget build(BuildContext context) {
    Color backcolor = color ?? Colors.white;
    WrapCrossAlignment? crossAxisalignment =
        crossAxisAlignment ?? WrapCrossAlignment.start;
    return Container(
        margin: margin,
        color: backcolor,
        width: width,
        height: height,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Wrap(crossAxisAlignment: crossAxisalignment, children: children)
        ]));
  }
}
