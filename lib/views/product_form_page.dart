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

      // Limpa os campos
      _title.clear();
      _price.clear();
      _description.clear();
      _category.clear();
      _image.clear();

      //Mostra uma mensagem ao cadastrar
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

  InputDecoration _inputDecoration(String labelText, IconData icon) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Color(0xFF1A237E),
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
      hintText: labelText,
      hintStyle: const TextStyle(
        color: Colors.black87,
        fontSize: 14,
        fontStyle: FontStyle.italic,
      ),

      prefixIcon: Icon(icon, color: Colors.blueAccent),
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: Color(0xFF1A237E), width: 2),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: Colors.redAccent, width: 1.5),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: Colors.redAccent, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1565C0),
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
                      validator: (i) {
                        if (i == null || i.isEmpty) {
                          return 'Informe a URL do produto';
                        }
                        final urlPattern =
                            r'(http|https):\/\/(\w+:?\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?';
                        final result = RegExp(urlPattern).hasMatch(i);
                        return result ? null : 'Informe uma URL válida';
                      },
                    ),

                    const SizedBox(height: 24),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFF1565C0),
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
