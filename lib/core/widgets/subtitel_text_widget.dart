import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubtitelTextWidget extends StatelessWidget {
  const SubtitelTextWidget({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 18,
    this.color,
    this.overflow = TextOverflow.ellipsis,
    this.fontStyle = FontStyle.normal,
    this.maxLines,
    this.decoration = TextDecoration.none,
  });
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final TextOverflow? overflow;
  final FontStyle? fontStyle;
  final int? maxLines;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }
}
