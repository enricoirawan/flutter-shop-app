import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const Color primaryColor = Color(0xFFF46036);
const Color secondaryColor = Color(0xFFF6F6F6);
const Color grayColor = Color(0xFFA9A9A9);

final TextTheme myTextTheme = TextTheme(
  headline1: GoogleFonts.lato(
    fontSize: 92.sp,
    fontWeight: FontWeight.w300,
  ),
  headline2: GoogleFonts.lato(
    fontSize: 57.sp,
    fontWeight: FontWeight.w300,
  ),
  headline3: GoogleFonts.lato(
    fontSize: 46.sp,
    fontWeight: FontWeight.w400,
  ),
  headline4: GoogleFonts.lato(
    fontSize: 32.sp,
    fontWeight: FontWeight.w400,
  ),
  headline5: GoogleFonts.lato(
    fontSize: 23,
    fontWeight: FontWeight.w400,
  ),
  headline6: GoogleFonts.lato(
    fontSize: 19.sp,
    fontWeight: FontWeight.w500,
  ),
  subtitle1: GoogleFonts.lato(
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
  ),
  subtitle2: GoogleFonts.lato(
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
  ),
  bodyText1: GoogleFonts.roboto(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  ),
  bodyText2: GoogleFonts.roboto(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  ),
  button: GoogleFonts.roboto(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  ),
  caption: GoogleFonts.roboto(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  ),
  overline: GoogleFonts.roboto(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
  ),
);
