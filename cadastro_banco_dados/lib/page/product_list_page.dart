import 'package:cadastro_banco_dados/database/product_database.dart';
import 'package:flutter/material.dart';
import '../model/produto_model.dart';
import 'product_form_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  Future<List<ProdutoModel>> _carregaProdutos() async {
    final db = ProductDatabase();
    return await db.findAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista e Cadastro de Produto',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: const [
          IconButton(
            icon: Icon(Icons.list, color: Colors.white),
            onPressed: null,
          )
        ],
      ),
      backgroundColor: Colors.deepPurple[100],
      body: Scaffold(
        backgroundColor: Colors.grey[100],
        body: FutureBuilder<List<ProdutoModel>>(
          future: _carregaProdutos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                    'Erro ao carregar lista de produtos: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'Nenhum produto cadastrado.',
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                ),
              );
            }
            final listaproduto = snapshot.data;

            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                final produto = listaproduto![index];
                return ListTile(
                  title: Text(produto.nome),
                  subtitle: Text(
                      'Preço: ${produto.preco?.toStringAsFixed(2) ?? '0.00'}'),
                  leading: const Icon(Icons.shopping_bag),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          ProdutoModel? produto = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProductFormPage(),
            ),
          );
          if (produto != null) {
            final db = ProductDatabase();
            await db.insertProduct(produto);
            setState(() {});
          }
        },
        label: const Text(
          'Novo Produto',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}
