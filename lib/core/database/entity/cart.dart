import 'package:floor/floor.dart';

@entity
class Cart {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String productTitle;
  final double price;
  final int amount;

  const Cart({
    this.id = 0,
    required this.productTitle,
    required this.price,
    required this.amount,
  });
}
