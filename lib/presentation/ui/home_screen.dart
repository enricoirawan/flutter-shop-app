import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_app/common/styles.dart';
import 'package:flutter_shop_app/core/state/view_state.dart';
import 'package:flutter_shop_app/domain/entity/response/product_entity.dart';
import 'package:flutter_shop_app/presentation/bloc/address_bloc/address_cubit.dart';
import 'package:flutter_shop_app/presentation/bloc/product_bloc/product_cubit.dart';
import 'package:flutter_shop_app/presentation/bloc/product_category/product_category_cubit.dart';
import 'package:flutter_shop_app/presentation/widget/category.dart';
import 'package:flutter_shop_app/presentation/widget/category_shimmer.dart';
import 'package:flutter_shop_app/presentation/widget/logo.dart';
import 'package:flutter_shop_app/presentation/widget/product.dart';
import 'package:flutter_shop_app/presentation/widget/product_shimmer.dart';
import 'package:flutter_shop_app/presentation/widget/search.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int categoryActiveIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<AddressCubit>().getUserAddress();
  }

  void selectCategory(int index, String selectedCategory) {
    setState(() {
      categoryActiveIndex = index;
    });

    context.read<ProductCubit>().getAllProducts(selectedCategory);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    const double productWidgetHeight = 200;
    final double itemHeight =
        (size.height - kToolbarHeight - productWidgetHeight) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Start: Logo
              LogoWidget(
                fontSize: 35.sp,
                color: secondaryColor,
                isFontbold: true,
              ),
              // End: Logo

              // Start: Search Widget
              const SearchWidget(),
              // End: Search Widget

              // Start: Address
              Container(
                margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_pin,
                      color: primaryColor,
                      size: 25,
                    ),
                    Text(
                      "Deliver to ",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    BlocBuilder<AddressCubit, AddressState>(
                      builder: (context, state) {
                        final status = state.addressState.status;

                        if (status.isLoading) {
                          return SizedBox(
                            width: 10.w,
                            height: 10.w,
                            child: const CircularProgressIndicator(),
                          );
                        } else {
                          return Expanded(
                            child: Text(
                              state.addressState.data,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: secondaryColor,
                                  ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              // End: Address

              //Start: Categories
              SizedBox(
                height: 15.h,
              ),
              BlocBuilder<ProductCategoryCubit, ProductCategoryState>(
                builder: (context, state) {
                  final status = state.productCategoryState.status;
                  final categories = state.productCategoryState.data;

                  if (status.isLoading) {
                    return const CategoryShimmerWidget();
                  } else if (status.isHasData) {
                    return SizedBox(
                      height: 30.h,
                      width: double.infinity,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final String category = categories[index];
                          return CategoryWidget(
                            index: index,
                            totalData: categories.length,
                            category: category,
                            isActive: categoryActiveIndex == index,
                            onTap: () {
                              selectCategory(index, categories[index]);
                            },
                          );
                        },
                        itemCount: categories.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    );
                  } else {
                    return Container(
                      margin: EdgeInsets.only(top: 50.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          LottieBuilder.asset(
                            "assets/error.json",
                            height: 150.h,
                          ),
                          Text(state.productCategoryState.message),
                        ],
                      ),
                    );
                  }
                },
              ),
              //End: Categories

              SizedBox(
                height: 20.h,
              ),
              //Start: Products
              BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  final status = state.productState.status;
                  final products = state.productState.data ?? [];

                  if (status.isLoading) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 1.85,
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: (itemWidth / itemHeight),
                        children: const [
                          ProductWidgetShimmer(),
                          ProductWidgetShimmer(),
                          ProductWidgetShimmer(),
                          ProductWidgetShimmer(),
                          ProductWidgetShimmer(),
                          ProductWidgetShimmer(),
                          ProductWidgetShimmer(),
                          ProductWidgetShimmer(),
                        ],
                      ),
                    );
                  } else if (status.isHasData) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 1.70,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          childAspectRatio: (itemWidth / itemHeight),
                        ),
                        itemBuilder: (context, index) {
                          final ProductEntity product = products[index];
                          return ProductWidget(product: product);
                        },
                        shrinkWrap: true,
                        itemCount: products.length,
                      ),
                    );
                  }

                  return Container();
                },
              ),
              //End: Products
            ],
          ),
        ),
      ),
    );
  }
}
