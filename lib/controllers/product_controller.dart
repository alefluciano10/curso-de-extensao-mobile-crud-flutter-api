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
      await Future.delayed(const Duration(seconds: 3));
      products.value = await _service.getAllProducts();
    } catch (e) {
      if (kDebugMode) {
        print('Erro: $e');
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> addProduct(Product p) async {
    try {
      final product = await _service.addProduct(
        p,
      ); //Chama o método salvar do service

      if (product.id != null) {
        products.add(product);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao cadastrar o produto: $e');
      }
    }
  }
}
