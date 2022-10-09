import 'package:floor/floor.dart';

@entity
class TransactionData {
  @PrimaryKey()
  final String id;
  final double total;
  final String purcashedProductTitle;

  const TransactionData({
    required this.id,
    required this.total,
    required this.purcashedProductTitle,
  });
}
