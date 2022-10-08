import 'package:equatable/equatable.dart';
import 'package:flutter_shop_app/domain/entity/response/product_entity.dart';

class DetailProductArgument extends Equatable {
  final ProductEntity product;

  const DetailProductArgument({
    required this.product,
  });

  @override
  List<Object?> get props => [product];
}
