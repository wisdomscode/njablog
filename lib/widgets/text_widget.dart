import 'package:flutter/material.dart';

class MyTextWidget extends StatelessWidget {
  const MyTextWidget({
    super.key,
    required this.text,
    this.color,
    this.size,
    this.fontWeight,
    this.overflow,
    this.maxLines,
  });

  final String text;
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? Colors.grey.shade800,
        fontSize: size,
        fontWeight: fontWeight,
      ),
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
