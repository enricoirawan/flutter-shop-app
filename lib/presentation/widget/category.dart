import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_app/common/styles.dart';

class CategoryWidget extends StatelessWidget {
  final String category;
  final bool isActive;
  final VoidCallback onTap;
  final int index;
  final int totalData;

  const CategoryWidget({
    Key? key,
    required this.category,
    required this.isActive,
    required this.onTap,
    required this.index,
    required this.totalData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
          left: 16.w,
          right: index == totalData - 1 ? 16.w : 0,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          border: Border.all(
            color: isActive ? whiteColor : secondaryColor,
          ),
          borderRadius: BorderRadius.circular(6),
          color: isActive ? primaryColor : whiteColor,
        ),
        child: Center(
          child: Text(
            category,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: isActive ? whiteColor : blackColor,
                ),
          ),
        ),
      ),
    );
  }
}
