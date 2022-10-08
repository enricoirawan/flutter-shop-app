import 'package:flutter/material.dart';
import 'package:flutter_shop_app/common/styles.dart';

class LogoWidget extends StatelessWidget {
  final double fontSize;
  final Color color;
  final bool isFontbold;

  const LogoWidget({
    Key? key,
    required this.fontSize,
    required this.color,
    required this.isFontbold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "logo",
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "e",
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontWeight: isFontbold ? FontWeight.bold : FontWeight.normal,
                  color: primaryColor,
                  fontSize: fontSize,
                ),
          ),
          Text(
            "Shop",
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontWeight: isFontbold ? FontWeight.bold : FontWeight.normal,
                  color: color,
                  fontSize: fontSize,
                ),
          ),
        ],
      ),
    );
  }
}
