import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/styles.dart';

class ProductWidgetShimmer extends StatelessWidget {
  const ProductWidgetShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      margin: EdgeInsets.only(
        left: 10.w,
        right: 10.w,
        bottom: 10.h,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            offset: Offset(4, 4),
            spreadRadius: -3,
            blurRadius: 10,
            color: grayColor,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const FadeShimmer(
            height: 150,
            width: double.infinity,
            radius: 4,
            highlightColor: grayColor,
            baseColor: Color(0xffE6E8EB),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: 6.h,
              left: 5.w,
              right: 5.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                FadeShimmer(
                  height: 15,
                  width: double.infinity,
                  radius: 4,
                  highlightColor: grayColor,
                  baseColor: Color(0xffE6E8EB),
                ),
                SizedBox(
                  height: 10,
                ),
                FadeShimmer(
                  height: 15,
                  width: double.infinity,
                  radius: 4,
                  highlightColor: grayColor,
                  baseColor: Color(0xffE6E8EB),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
