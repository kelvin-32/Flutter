import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Produto {
  final String nome;
  final double preco;
  final String imagemUrl;
  Produto(this.nome, this.preco, this.imagemUrl);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carrinho de Compras',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CarrinhoPage(),
    );
  }
}

class CarrinhoPage extends StatefulWidget {
  const CarrinhoPage({super.key});

  @override
  State<CarrinhoPage> createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {
  final List<Produto> produtos = [
    Produto(
      'Maçã',
      2.5,
      'https://images.unsplash.com/photo-1567306226416-28f0efdc88ce?auto=format&fit=crop&w=150&q=80',
    ),
    Produto(
      'Banana',
      1.8,
      'https://media.istockphoto.com/id/959104928/pt/foto/banana.webp?a=1&b=1&s=612x612&w=0&k=20&c=HlFjkoCBPWRmUJNC1NVk8BeEIywZ-uEnGuCBIXX9BCA=',
    ),
    Produto(
      'Laranja',
      3.0,
      'https://media.istockphoto.com/id/482078328/pt/foto/fundo-laranjado.webp?a=1&b=1&s=612x612&w=0&k=20&c=FB1dYJaP-iJc1JoEjhtR_u6bskV4JTlhiLuKz2zm7b0=',
    ),
    Produto(
      'Pão',
      4.5,
      'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cCVDMyVBM298ZW58MHx8MHx8fDA%3D',
    ),
    Produto(
      'Leite',
      5.0,
      'https://images.unsplash.com/photo-1563636619-e9143da7973b?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fGxlaXRlfGVufDB8fDB8fHww',
    ),
    Produto(
      'Café',
      6.2,
      'https://plus.unsplash.com/premium_photo-1675435644687-562e8042b9db?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y2FmJUMzJUE5fGVufDB8fDB8fHww',
    ),
  ];

  final List<Produto> carrinho = [];

  double get total => carrinho.fold(0, (sum, item) => sum + item.preco);

  void adicionarProduto(Produto produto) {
    setState(() {
      carrinho.add(produto);
    });
  }

  void removerProduto(Produto produto) {
    setState(() {
      carrinho.remove(produto);
    });
  }

  void limparCarrinho() {
    setState(() {
      carrinho.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho de Compras'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 3 / 2,
                ),
                itemCount: produtos.length,
                itemBuilder: (context, index) {
                  final produto = produtos[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(produto.nome,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        Image.network(produto.imagemUrl,
                            height: 50, fit: BoxFit.cover),
                        Text('R\$ ${produto.preco.toStringAsFixed(2)}'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () => adicionarProduto(produto),
                              child: const Text('Adicionar'),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () => removerProduto(produto),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              child: const Text('Remover'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blueGrey.shade100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total: R\$ ${total.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                    onPressed: limparCarrinho,
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Limpar Carrinho'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
