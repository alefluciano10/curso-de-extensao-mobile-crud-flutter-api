import 'package:crud_flutter_api/controllers/product_controller.dart';
import 'package:crud_flutter_api/models/product.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _price = TextEditingController();
  final _description = TextEditingController();
  final _category = TextEditingController();
  final _image = TextEditingController();

  final _controller = Get.find<ProductController>();

  //Método para salvar
  void _save() {
    if (_formKey.currentState!.validate()) {
      final product = Product(
        id: null,
        title: _title.text,
        price: double.parse(_price.text),
        description: _description.text,
        category: _category.text,
        image: _image.text,
      );
      _controller.addProduct(product);
      Get.back();
      Get.snackbar(
        'Sucesso',
        'Produto cadastrado com sucesso!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    }
  }

  InputDecoration _inputDecoration(String hintText, IconData icon) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(icon, color: Colors.indigo),
      filled: true,
      fillColor: Colors.white,
      hintStyle: const TextStyle(fontSize: 14, color: Colors.black87),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.indigo, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastrar Produto',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Card(
            margin: const EdgeInsets.all(16),
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      controller: _title,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: _inputDecoration(
                        'Nome do produto',
                        Icons.shopping_bag,
                      ),
                      validator:
                          (t) =>
                              t!.isEmpty ? 'Informe o nome do produto' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _price,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: _inputDecoration('Preço', Icons.attach_money),
                      validator:
                          (p) =>
                              p!.isEmpty ? 'Informe o preço do produto' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _description,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: _inputDecoration(
                        'Descrição',
                        Icons.description,
                      ),
                      validator:
                          (d) =>
                              d!.isEmpty
                                  ? 'Informe a descrição do produto'
                                  : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _category,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: _inputDecoration('Categoria', Icons.category),
                      validator:
                          (c) =>
                              c!.isEmpty
                                  ? 'Informe a categoria do produto'
                                  : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _image,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      decoration: _inputDecoration('URL Imagem', Icons.image),
                      validator:
                          (i) => i!.isEmpty ? 'Informe a URL do produto' : null,
                    ),

                    const SizedBox(height: 24),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: _save,
                      child: const Text('Cadastrar Produto'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
