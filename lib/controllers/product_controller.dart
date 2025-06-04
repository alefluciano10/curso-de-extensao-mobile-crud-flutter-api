import 'package:crud_flutter_api/models/product.dart';
import 'package:crud_flutter_api/services/product_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

//Criando a classe ProductController
class ProductController extends GetxController {
  final ProductService _service = ProductService();
  var products = <Product>[].obs;

  //Inicializando
  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  //Loading
  var isLoading = false.obs;

  void fetchProducts() async {
    isLoading(true);
    try {
      Future.delayed(const Duration(seconds: 3));
      products.value = await _service.getAllProducts();
    } catch (e) {
      if (kDebugMode) {
        print('Erro: $e');
      }
    } finally {
      isLoading(false);
    }
  }
}
