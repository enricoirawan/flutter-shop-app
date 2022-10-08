part of 'product_cubit.dart';

class ProductState extends Equatable {
  final ViewData<List<ProductEntity>> productState;

  const ProductState({
    required this.productState,
  });

  ProductState copyWith({
    ViewData<List<ProductEntity>>? productState,
  }) {
    return ProductState(
      productState: productState ?? this.productState,
    );
  }

  @override
  List<Object> get props => [productState];
}
