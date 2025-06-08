import 'package:crud_flutter_api/models/product.dart';
import 'package:crud_flutter_api/services/product_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

//Criando a classe ProductController
class ProductController extends GetxController {
  final ProductService _service = ProductService();

  var products = <Product>[].obs;
  var categories = <String>[].obs;
  var isLoading = false.obs;

  var searchQuery = ''.obs;
  var selectedCategory = 'Todas as categorias'.obs;

  //Inicializando
  @override
  void onInit() {
    fetchProducts();
    fetchCategories();
    super.onInit();
  }

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

  void fetchCategories() async {
    try {
      final fetched = await _service.getCategories();
      categories.assignAll(fetched);
    } catch (e) {
      Get.snackbar('Erro', 'Erro ao buscar categorias');
    }
  }

  List<Product> get filteredProducts {
    var temp =
        selectedCategory.value == 'Todas as categorias'
            ? products
            : products
                .where((p) => p.category == selectedCategory.value)
                .toList();

    if (searchQuery.value.isNotEmpty) {
      temp =
          temp
              .where(
                (p) => p.title.toLowerCase().contains(
                  searchQuery.value.toLowerCase(),
                ),
              )
              .toList();
    }

    return temp;
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
