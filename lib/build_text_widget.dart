import 'package:flutter/material.dart';

class BuildTextWidget extends StatelessWidget {
  final String text;
  final double? size;
  final Color? textColor;

  const BuildTextWidget({
    super.key,
    required this.text,
    this.size,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: size ?? 15, color: textColor),
    );
  }
}
