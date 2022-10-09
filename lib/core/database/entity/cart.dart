import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class Cart extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String productTitle;
  final double price;
  final int amount;
  final String image;

  const Cart({
    required this.id,
    required this.productTitle,
    required this.price,
    required this.amount,
    required this.image,
  });

  @override
  List<Object?> get props => [
        id,
        productTitle,
        price,
        amount,
        image,
      ];
}
