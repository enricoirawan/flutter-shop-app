import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_shop_app/core/state/view_state.dart';
import 'package:flutter_shop_app/core/use_case/use_case.dart';
import 'package:flutter_shop_app/domain/entity/response/product_entity.dart';
import 'package:flutter_shop_app/domain/usecase/get_all_products_usecase.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetAllProductsUseCase getAllProductsUseCase;

  ProductCubit({
    required this.getAllProductsUseCase,
  }) : super(
          ProductState(
            productState: ViewData.initial(),
          ),
        );

  void getAllProducts() async {
    emit(
      ProductState(productState: ViewData.loading()),
    );
    final response = await getAllProductsUseCase.call(const NoParams());

    response.fold(
      (error) {
        emit(
          ProductState(
            productState: ViewData.error(
              message: error.message,
              failure: error,
            ),
          ),
        );
      },
      (result) async {
        emit(
          ProductState(
            productState: ViewData.loaded(
              data: result,
            ),
          ),
        );
      },
    );
  }
}
