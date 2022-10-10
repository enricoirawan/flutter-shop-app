part of 'product_detail_cubit.dart';

class ProductDetailState extends Equatable {
  final ViewData<ProductEntity> productDetailState;

  const ProductDetailState({required this.productDetailState});

  ProductDetailState copyWith({
    ViewData<ProductEntity>? productDetailState,
  }) {
    return ProductDetailState(
      productDetailState: productDetailState ?? this.productDetailState,
    );
  }

  @override
  List<Object> get props => [productDetailState];
}
