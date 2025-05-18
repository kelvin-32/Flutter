import 'package:flutter/material.dart';

void main() {
  runApp(const CarrinhoApp());
}

class CarrinhoApp extends StatelessWidget {
  const CarrinhoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carrinho de Compras',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Produto {
  final String nome;
  final double preco;
  final String imagemUrl;

  Produto(this.nome, this.preco, this.imagemUrl);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double total = 0.0;

  final List<Produto> produtos = [
    Produto('Camiseta Vermelha', 29.99, 'https://placehold.co/150x100/FF0000/FFFFFF/png'),
    Produto('Calça Amarela', 49.99, 'https://placehold.co/150x100/FFFF00/000000/png'),
    Produto('Tênis Laranja', 89.99, 'https://placehold.co/150x100/FFA500/FFFFFF/png'),
    Produto('Chapéu Bege', 19.99, 'https://placehold.co/150x100/F5DEB3/000000/png'),
    Produto('Jaqueta Branca', 79.99, 'https://placehold.co/150x100/FFFFFF/000000/png'),
    Produto('Botas Marrons', 99.99, 'https://placehold.co/150x100/6F4E37/FFFFFF/png'),
  ];

  void adicionarAoCarrinho(double preco) {
    setState(() {
      total += preco;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho de Compras'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: produtos.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    final produto = produtos[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            blurRadius: 4,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.network(produto.imagemUrl, height: 80),
                          Text(produto.nome, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Text('R\$ ${produto.preco.toStringAsFixed(2)}', style: const TextStyle(color: Colors.green)),
                          ElevatedButton(
                            onPressed: () => adicionarAoCarrinho(produto.preco),
                            child: const Text('Adicionar'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.teal.shade100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('R\$ ${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
