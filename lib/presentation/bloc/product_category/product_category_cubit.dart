import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_shop_app/core/state/view_state.dart';
import 'package:flutter_shop_app/core/use_case/use_case.dart';
import 'package:flutter_shop_app/domain/usecase/get_all_categories_usecase.dart';

part 'product_category_state.dart';

class ProductCategoryCubit extends Cubit<ProductCategoryState> {
  final GetAllCategoriesUseCase getAllCategoriesUseCase;

  ProductCategoryCubit({
    required this.getAllCategoriesUseCase,
  }) : super(
          ProductCategoryState(
            productCategoryState: ViewData.initial(),
          ),
        );

  void getAllCategories() async {
    emit(
      ProductCategoryState(
        productCategoryState: ViewData.loading(),
      ),
    );
    final result = await getAllCategoriesUseCase.call(const NoParams());

    result.fold(
      (error) {
        emit(
          ProductCategoryState(
            productCategoryState: ViewData.error(
              message: error.message,
              failure: error,
            ),
          ),
        );
      },
      (result) {
        emit(
          ProductCategoryState(
            productCategoryState: ViewData.loaded(data: result),
          ),
        );
      },
    );
  }
}
