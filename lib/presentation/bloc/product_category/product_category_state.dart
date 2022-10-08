part of 'product_category_cubit.dart';

class ProductCategoryState extends Equatable {
  final ViewData productCategoryState;

  const ProductCategoryState({required this.productCategoryState});

  ProductCategoryState copyWith({
    ViewData? productCategoryState,
  }) {
    return ProductCategoryState(
      productCategoryState: productCategoryState ?? this.productCategoryState,
    );
  }

  @override
  List<Object> get props => [productCategoryState];
}
