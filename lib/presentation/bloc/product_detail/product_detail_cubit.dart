import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_shop_app/core/state/view_state.dart';
import 'package:flutter_shop_app/domain/entity/response/product_entity.dart';
import 'package:flutter_shop_app/domain/usecase/get_product_detail_usecase.dart';

part 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final GetProductDetailUseCase getProductDetailUseCase;

  ProductDetailCubit({
    required this.getProductDetailUseCase,
  }) : super(ProductDetailState(productDetailState: ViewData.initial()));

  void getProductDetail(int productId) async {
    emit(
      ProductDetailState(productDetailState: ViewData.loading()),
    );
    final response = await getProductDetailUseCase.call(productId);

    response.fold((error) {
      emit(
        ProductDetailState(
          productDetailState: ViewData.error(
            message: error.message,
            failure: error,
          ),
        ),
      );
    }, (result) {
      emit(
        ProductDetailState(productDetailState: ViewData.loaded(data: result)),
      );
    });
  }
}
