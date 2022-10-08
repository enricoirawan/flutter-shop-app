import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/styles.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      margin: EdgeInsets.only(top: 10.h, left: 16.w, right: 16.w),
      decoration: BoxDecoration(
        color: grayColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        margin: EdgeInsets.all(10.w),
        child: Row(
          children: [
            const Icon(Icons.search),
            SizedBox(
              width: 10.w,
            ),
            Text(
              "What are you looking for?",
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: grayColor,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
