import 'dart:convert';
import 'package:crud_flutter_api/models/product.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

//Criando a classe ProductService
class ProductService {
  final String baseURL = 'https://fakestoreapi.com/products';

  //Método para buscar os produtos
  Future<List<Product>> getAllProducts() async {
    final response = await http.get(Uri.parse(baseURL));

    if (response.statusCode == 200) {
      final List jsonList = json.decode(response.body);
      return jsonList.map((j) => Product.fromJson(j)).toList();
    } else {
      throw Exception('Erro aos buscar os produtos.');
    }
  }
}

//Testando a API
void main() async {
  ProductService service = ProductService();
  final listProducts = await service.getAllProducts();
  for (var prod in listProducts) {
    if (kDebugMode) {
      print('Titulo: ${prod.title} - Price: ${prod.price}');
    }
  }
}
