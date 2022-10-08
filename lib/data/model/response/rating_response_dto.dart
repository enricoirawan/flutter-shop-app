import 'package:equatable/equatable.dart';
import 'package:flutter_shop_app/domain/entity/response/rating_entity.dart';

class Rating extends Equatable {
  final double rate;
  final int count;

  const Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: json["rate"].toDouble(),
        count: json["count"],
      );

  RatingEntity mapToEntity() {
    return RatingEntity(rate: rate, count: count);
  }

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };

  @override
  List<Object?> get props => [
        rate,
        count,
      ];
}
