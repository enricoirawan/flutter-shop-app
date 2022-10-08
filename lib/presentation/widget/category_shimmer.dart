import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_app/common/styles.dart';

class CategoryShimmerWidget extends StatelessWidget {
  const CategoryShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            child: const FadeShimmer(
              height: 8,
              width: 150,
              radius: 4,
              highlightColor: grayColor,
              baseColor: Color(0xffE6E8EB),
            ),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
