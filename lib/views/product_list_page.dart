import 'package:crud_flutter_api/controllers/product_controller.dart';
import 'package:crud_flutter_api/custom/custom_dropdown.dart';
import 'package:crud_flutter_api/views/product_form_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListPage extends StatelessWidget {
  ProductListPage({super.key});

  final controller = Get.find<ProductController>();
  final _searchController = TextEditingController();

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

        final allCategories = ['Todas as categorias', ...controller.categories];

        return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              // 🔍 Filtro e busca (Fixo)
              CustomDropdown(
                label: 'Pesquisa por categoria',
                value: controller.selectedCategory.value,
                items: allCategories,
                hint: 'Selecione uma categoria',
                onChanged: (value) {
                  controller.selectedCategory.value = value!;
                },
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: Obx(() {
                    return controller.searchQuery.value.isNotEmpty
                        ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            controller.searchQuery.value = '';
                          },
                        )
                        : const SizedBox.shrink();
                  }),
                  hintText: 'Buscar por nome...',
                  hintStyle: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 2,
                    ),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Color(0xFF1A237E), width: 2),
                  ),
                ),
                onChanged: (value) {
                  controller.searchQuery.value = value;
                },
              ),
              const SizedBox(height: 16),

              Expanded(
                child: Scrollbar(
                  thumbVisibility: true,
                  thickness: 8, // largura da barra
                  radius: const Radius.circular(12), // cantos arredondados
                  trackVisibility: true, // exibe o trilho de fundo
                  scrollbarOrientation:
                      ScrollbarOrientation.right, // posição direita
                  interactive: true, // permite clicar e arrastar

                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 54),

                    child: ListView.builder(
                      itemCount: controller.filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = controller.filteredProducts[index];

                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),

                          child: Stack(
                            children: [
                              ListTile(
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
                                            const Icon(Icons.image, size: 60),
                                  ),
                                ),

                                title: Text(
                                  product.title,
                                  maxLines: 2,
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
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
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
