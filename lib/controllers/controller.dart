import 'package:crud_flutter_api/models/product.dart';
import 'package:crud_flutter_api/services/product_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

//Criando a classe ProductController
class ProductController {
  final ProductService _service = ProductService();
  var products = <Product>[].obs;

  //Loading
  var isLoading = false.obs;

  void fetchProducts() async {
    isLoading(true);
    try {
      products.value = await _service.getAllProducts();
    } catch (e) {
      if (kDebugMode) {
        print('Erro: ${e}');
      }
    } finally {
      isLoading(false);
    }
  }
}
