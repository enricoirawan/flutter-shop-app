import 'package:dio/dio.dart';
import 'package:flutter_shop_app/data/model/response/product_response_dto.dart';

import '../../../common/constant.dart';

abstract class ProductRemoteDataSources {
  Future<List<dynamic>> getAllCategories();
  Future<List<ProductResponseDto>> getAllProducts();
}

class ProductRemoteDataSourcesImpl implements ProductRemoteDataSources {
  final Dio dio;

  ProductRemoteDataSourcesImpl({required this.dio});

  @override
  Future<List<dynamic>> getAllCategories() async {
    try {
      final response = await dio.get(
        "${AppConstants.appApi.baseUrl}${AppConstants.appApi.categories}",
      );

      response.data.insert(0, "All");

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ProductResponseDto>> getAllProducts() async {
    try {
      final response = await dio.get(
        "${AppConstants.appApi.baseUrl}${AppConstants.appApi.products}",
      );

      List<ProductResponseDto> products = [];

      for (var data in response.data) {
        products.add(ProductResponseDto.fromJson(data));
      }

      return products;
    } catch (e) {
      rethrow;
    }
  }
}