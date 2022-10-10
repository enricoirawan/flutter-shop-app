import 'package:equatable/equatable.dart';

class DetailProductArgument extends Equatable {
  final int productId;

  const DetailProductArgument({
    required this.productId,
  });

  @override
  List<Object?> get props => [productId];
}
