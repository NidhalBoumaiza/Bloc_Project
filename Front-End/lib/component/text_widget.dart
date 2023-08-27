import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget TextWidget(text, color, size, fontweight, letterspacing,
    {TextAlign? textalign}) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      fontSize: size,
      color: color,
      fontWeight: fontweight,
      letterSpacing: letterspacing,
    ),
    textAlign: textalign ?? TextAlign.start,
  );
}
