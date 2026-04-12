import 'package:dio/dio.dart';
import 'package:estosimple_app/models/api_response.dart';
import 'package:estosimple_app/models/product.dart';
import 'package:estosimple_app/services/api_service.dart';
import 'package:flutter/cupertino.dart';

class ProductsService {
  final Dio _dio = ApiService().dio;

  Future<List<Product>> getProducts() async {
    final response = await _dio.get('/products',);

    debugPrint('RESPONSE[${response.statusCode}] => BODY[${response.data}]');

    final apiResponse = ApiResponse<List<Product>>.fromJson(
      response.data,
      (value) {
        final list = (value as List?) ?? [];

        return list.map((p) => Product.fromJson(p)).toList();
      }
    );

    if (!apiResponse.isSuccess) {
      throw apiResponse.message;
    }

    return apiResponse.value;
  }

  Future<Product> createProduct(Product product) async {
    final response = await _dio.post(
      '/products',
      data: product.toJson()
    );

    final apiResponse = ApiResponse.fromJson(
      response.data, 
      (value) {
        return Product.fromJson(value as Map<String, dynamic>);
      }
    );

    if (!apiResponse.isSuccess) {
      throw apiResponse.message;
    }

    return apiResponse.value;
  }

  Future<Product> updateProduct(Product product) async {
    final response = await _dio.put(
      '/products/${product.id}',
      data: product.toJson()
    );

    final apiResponse = ApiResponse.fromJson(
      response.data, 
      (value) {
        return Product.fromJson(value as Map<String, dynamic>);
      }
    );

    if (!apiResponse.isSuccess) {
      throw apiResponse.message;
    }

    return apiResponse.value;
  }

  Future<void> deleteProduct(int id) async {
    final response = await _dio.delete('/products/$id');

    final apiResponse = ApiResponse.fromJson(
      response.data, 
      (value) {
        return value;
      }
    );

    if (!apiResponse.isSuccess) {
      throw apiResponse.message;
    }
  }
}