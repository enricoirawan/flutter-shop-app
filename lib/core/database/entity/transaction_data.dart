import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class TransactionData extends Equatable {
  @PrimaryKey()
  final String id;
  final double total;
  final String purcashedProductTitle;

  const TransactionData({
    required this.id,
    required this.total,
    required this.purcashedProductTitle,
  });

  @override
  List<Object?> get props => [
        id,
        total,
        purcashedProductTitle,
      ];
}
