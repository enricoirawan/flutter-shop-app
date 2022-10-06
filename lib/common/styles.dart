import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const Color primaryColor = Color(0xFFF46036);
const Color secondaryColor = Color(0xFF27386D);
const Color grayColor = Color(0xFF909399);
const Color blackColor = Color(0xFF000000);
const Color whiteColor = Color(0xFFFFFFFF);

final TextTheme myTextTheme = TextTheme(
  headline1: GoogleFonts.inter(
    fontSize: 92.sp,
    fontWeight: FontWeight.w300,
  ),
  headline2: GoogleFonts.inter(
    fontSize: 57.sp,
    fontWeight: FontWeight.w300,
  ),
  headline3: GoogleFonts.inter(
    fontSize: 46.sp,
    fontWeight: FontWeight.w400,
  ),
  headline4: GoogleFonts.inter(
    fontSize: 32.sp,
    fontWeight: FontWeight.w400,
  ),
  headline5: GoogleFonts.inter(
    fontSize: 23,
    fontWeight: FontWeight.w400,
  ),
  headline6: GoogleFonts.inter(
    fontSize: 19.sp,
    fontWeight: FontWeight.w500,
  ),
  subtitle1: GoogleFonts.inter(
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
  ),
  subtitle2: GoogleFonts.inter(
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
  ),
  bodyText1: GoogleFonts.inter(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  ),
  bodyText2: GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  ),
  button: GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  ),
  caption: GoogleFonts.inter(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  ),
  overline: GoogleFonts.inter(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
  ),
);
