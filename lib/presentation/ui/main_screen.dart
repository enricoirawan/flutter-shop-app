import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/common/styles.dart';
import 'package:flutter_shop_app/presentation/ui/cart_screen.dart';
import 'package:flutter_shop_app/presentation/ui/home_screen.dart';
import 'package:flutter_shop_app/presentation/ui/profile_screen.dart';

import '../bloc/bottom_nav_bloc/bottom_nav_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<IconData> iconList = [
      Icons.home,
      Icons.account_circle,
    ];

    return Scaffold(
      body: BlocBuilder<BottomNavCubit, int>(builder: (context, state) {
        if (state == 0) {
          return const HomeScreen();
        } else if (state == 1) {
          return const ProfileScreen();
        } else if (state == 2) {
          return const CartScreen();
        }

        return const HomeScreen();
      }), //
      floatingActionButton: BlocBuilder<BottomNavCubit, int>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () {
              context.read<BottomNavCubit>().changePage(2);
            },
            backgroundColor: state == 2 ? primaryColor : grayColor,
            child: const Icon(Icons.shopping_cart),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BlocBuilder<BottomNavCubit, int>(
        builder: (context, state) {
          return AnimatedBottomNavigationBar(
            icons: iconList,
            activeIndex: state,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.softEdge,
            onTap: (int page) {
              context.read<BottomNavCubit>().changePage(page);
            },
            activeColor: primaryColor,
            inactiveColor: grayColor,
            //other params
          );
        },
      ),
    );
  }
}
