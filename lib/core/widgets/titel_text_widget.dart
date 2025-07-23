import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitelTextWidget extends StatelessWidget {
  const TitelTextWidget({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.bold,
    this.fontSize = 20,
    this.color,
    this.overflow = TextOverflow.ellipsis,
    this.fontStyle = FontStyle.normal,
    this.maxLines,
    this.decoration = TextDecoration.none,
    this.hight,
    this.textAlign,
  });
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final TextOverflow? overflow;
  final FontStyle? fontStyle;
  final int? maxLines;
  final TextDecoration? decoration;
  final double? hight;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign,
      text,
      maxLines: maxLines,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: hight,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }
}
