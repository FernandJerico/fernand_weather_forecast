import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextShadow extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  const TextShadow({
    super.key,
    required this.title,
    required this.fontSize,
    this.fontWeight = FontWeight.w400,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.overpass(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: Colors.white,
        shadows: [
          const Shadow(
            offset: Offset(-2.0, 3.0),
            blurRadius: 1.0,
            color: Color(0x1A000000),
          ),
          const Shadow(
            offset: Offset(-1.0, 1.0),
            blurRadius: 2.0,
            color: Color(0x40FFFFFF),
          ),
        ],
      ),
    );
  }
}
