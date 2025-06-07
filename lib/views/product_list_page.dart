import 'package:crud_flutter_api/controllers/product_controller.dart';
import 'package:crud_flutter_api/views/product_form_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListPage extends StatelessWidget {
  ProductListPage({super.key});

  final controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Lista de Produtos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            final product = controller.products[index];
            return Card(
              color: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: EdgeInsets.only(bottom: 16),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.image,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) =>
                            Icon(Icons.image_not_supported),
                  ),
                ),

                title: Text(
                  product.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF2C2C2C),
                  ),
                ),

                subtitle: Text(
                  'R\$ ${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Color(0xFF00695C),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          },
        );
      }),

      //Botão que leva para a tela de cadastrar o produto
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const ProductFormPage());
        },
        backgroundColor: Color(0xFF1565C0),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
