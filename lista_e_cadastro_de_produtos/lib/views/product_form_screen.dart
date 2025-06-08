import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/product_controller.dart';
import '../widgets/custom_dropdown.dart';
import '../models/product.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? product;
  final int? index;
  const ProductFormScreen({super.key, this.product, this.index});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String? titulo;
  String? descricao;
  String? categoria;
  String? imagemUrl;
  double? preco;

  @override
  void initState() {
    super.initState();
    final controller = Provider.of<ProductController>(context, listen: false);
    controller.loadCategories();
    if (widget.product != null) {
      titulo = widget.product!.titulo;
      descricao = widget.product!.descricao;
      categoria = widget.product!.categoria;
      imagemUrl = widget.product!.imagemUrl;
      preco = widget.product!.preco;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.product == null ? 'Cadastrar Produto' : 'Editar Produto',
              style: const TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    initialValue: titulo,
                    decoration: const InputDecoration(
                      labelText: 'Título',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Informe o título'
                        : null,
                    onSaved: (value) => titulo = value,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: preco?.toString(),
                    decoration: const InputDecoration(
                      labelText: 'Preço',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Informe o preço';
                      final parsed =
                          double.tryParse(value.replaceAll(',', '.'));
                      if (parsed == null) return 'Preço inválido';
                      return null;
                    },
                    onSaved: (value) =>
                        preco = double.tryParse(value!.replaceAll(',', '.')),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: descricao,
                    decoration: const InputDecoration(
                      labelText: 'Descrição',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Informe a descrição'
                        : null,
                    onSaved: (value) => descricao = value,
                  ),
                  const SizedBox(height: 16),
                  CustomDropdown(
                    label: 'Categoria',
                    value: categoria,
                    items: controller.categories,
                    onChanged: (value) {
                      setState(() {
                        categoria = value;
                      });
                    },
                    hint: 'Selecione uma categoria',
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: imagemUrl,
                    decoration: const InputDecoration(
                      labelText: 'URL da Imagem',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Informe a URL da imagem'
                        : null,
                    onSaved: (value) => imagemUrl = value,
                    onChanged: (value) {
                      setState(() {
                        imagemUrl = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  if (imagemUrl != null && imagemUrl!.isNotEmpty)
                    Column(
                      children: [
                        Center(
                          child: Image.network(
                            imagemUrl!,
                            height: 180,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image,
                                    size: 80, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: TextButton.icon(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            label: const Text('Remover imagem',
                                style: TextStyle(color: Colors.red)),
                            onPressed: () {
                              setState(() {
                                imagemUrl = '';
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate() &&
                            categoria != null) {
                          _formKey.currentState!.save();
                          final product = Product(
                            titulo: titulo!,
                            preco: preco!,
                            descricao: descricao!,
                            categoria: categoria!,
                            imagemUrl: imagemUrl ?? '',
                          );
                          if (widget.product == null) {
                            await controller.addProduct(product);
                          } else {
                            await controller.updateProduct(
                                widget.index!, product);
                          }
                          if (context.mounted) Navigator.pop(context);
                        }
                      },
                      child: Text(
                        widget.product == null ? 'Salvar' : 'Atualizar',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
