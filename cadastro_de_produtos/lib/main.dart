// main.dart
import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Produtos',
      home: TelaCadastro(),
    );
  }
}

class Produto {
  String nome;
  double precoCompra;
  double precoVenda;
  int quantidade;
  String descricao;
  String categoria;
  String imagemUrl;
  bool ativo;
  bool promocao;
  double desconto;

  Produto({
    required this.nome,
    required this.precoCompra,
    required this.precoVenda,
    required this.quantidade,
    required this.descricao,
    required this.categoria,
    required this.imagemUrl,
    required this.ativo,
    required this.promocao,
    required this.desconto,
  });
}

List<Produto> produtos = [];

class TelaCadastro extends StatefulWidget {
  final Produto? produtoEditado;
  final int? index;

  TelaCadastro({this.produtoEditado, this.index});

  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _precoCompraController = TextEditingController();
  final _precoVendaController = TextEditingController();
  final _quantidadeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _imagemController = TextEditingController();
  String _categoria = 'Outros';
  bool _ativo = false;
  bool _promocao = false;
  double _desconto = 0;

  @override
  void initState() {
    super.initState();
    if (widget.produtoEditado != null) {
      final p = widget.produtoEditado!;
      _nomeController.text = p.nome;
      _precoCompraController.text = p.precoCompra.toString();
      _precoVendaController.text = p.precoVenda.toString();
      _quantidadeController.text = p.quantidade.toString();
      _descricaoController.text = p.descricao;
      _imagemController.text = p.imagemUrl;
      _categoria = p.categoria;
      _ativo = p.ativo;
      _promocao = p.promocao;
      _desconto = p.desconto;
    }
  }

  void _cadastrarProduto() {
    if (_formKey.currentState!.validate()) {
      Produto novoProduto = Produto(
        nome: _nomeController.text,
        precoCompra: double.parse(_precoCompraController.text),
        precoVenda: double.parse(_precoVendaController.text),
        quantidade: int.parse(_quantidadeController.text),
        descricao: _descricaoController.text,
        categoria: _categoria,
        imagemUrl: _imagemController.text,
        ativo: _ativo,
        promocao: _promocao,
        desconto: _desconto,
      );

      setState(() {
        if (widget.index != null) {
          produtos[widget.index!] = novoProduto;
        } else {
          produtos.add(novoProduto);
        }
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TelaListaProdutos()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.produtoEditado != null
              ? 'Editar Produto'
              : 'Cadastro de Produto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nomeController,
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: (value) =>
                      value!.isEmpty ? 'Campo obrigatório' : null,
                ),
                TextFormField(
                  controller: _precoCompraController,
                  decoration: InputDecoration(labelText: 'Preço de Compra'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Campo obrigatório' : null,
                ),
                TextFormField(
                  controller: _precoVendaController,
                  decoration: InputDecoration(labelText: 'Preço de Venda'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Campo obrigatório' : null,
                ),
                TextFormField(
                  controller: _quantidadeController,
                  decoration: InputDecoration(labelText: 'Quantidade'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Campo obrigatório' : null,
                ),
                TextFormField(
                  controller: _descricaoController,
                  decoration: InputDecoration(labelText: 'Descrição'),
                  validator: (value) =>
                      value!.isEmpty ? 'Campo obrigatório' : null,
                ),
                DropdownButtonFormField(
                  value: _categoria,
                  items: ['Eletrônicos', 'Roupas', 'Alimentos', 'Outros']
                      .map((e) => DropdownMenuItem(child: Text(e), value: e))
                      .toList(),
                  onChanged: (value) => setState(() => _categoria = value!),
                  decoration: InputDecoration(labelText: 'Categoria'),
                ),
                TextFormField(
                  controller: _imagemController,
                  decoration: InputDecoration(labelText: 'URL da Imagem'),
                ),
                SwitchListTile(
                  title: Text('Produto Ativo'),
                  value: _ativo,
                  onChanged: (value) => setState(() => _ativo = value),
                ),
                CheckboxListTile(
                  title: Text('Em Promoção'),
                  value: _promocao,
                  onChanged: (value) => setState(() => _promocao = value!),
                ),
                Slider(
                  value: _desconto,
                  min: 0,
                  max: 100,
                  divisions: 20,
                  label: '${_desconto.round()}%',
                  onChanged: (value) => setState(() => _desconto = value),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _cadastrarProduto,
                  child: Text(widget.produtoEditado != null
                      ? 'Salvar Alterações'
                      : 'Cadastrar Produto'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TelaListaProdutos extends StatelessWidget {
  void _editarProduto(BuildContext context, Produto produto, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TelaCadastro(produtoEditado: produto, index: index),
      ),
    );
  }

  void _removerProduto(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remover Produto'),
        content: Text('Tem certeza que deseja remover este produto?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              produtos.removeAt(index);
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => TelaListaProdutos()),
              );
            },
            child: Text('Remover'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Produtos')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Total de produtos: ${produtos.length}',
                style: TextStyle(fontSize: 16)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: produtos.length,
              itemBuilder: (context, index) {
                final produto = produtos[index];
                return ListTile(
                  leading: Image.network(
                    produto.imagemUrl,
                    width: 50,
                    height: 50,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.broken_image),
                  ),
                  title: Text(produto.nome),
                  subtitle:
                      Text('R\$ ${produto.precoVenda.toStringAsFixed(2)}'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TelaDetalhesProduto(produto: produto),
                    ),
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'editar') {
                        _editarProduto(context, produto, index);
                      } else if (value == 'remover') {
                        _removerProduto(context, index);
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(value: 'editar', child: Text('Editar')),
                      PopupMenuItem(value: 'remover', child: Text('Remover')),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TelaDetalhesProduto extends StatelessWidget {
  final Produto produto;

  TelaDetalhesProduto({required this.produto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalhes do Produto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                produto.imagemUrl,
                height: 200,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.broken_image, size: 100),
              ),
            ),
            SizedBox(height: 16),
            Text('Nome: ${produto.nome}', style: TextStyle(fontSize: 18)),
            Text(
                'Preço de Compra: R\$ ${produto.precoCompra.toStringAsFixed(2)}'),
            Text(
                'Preço de Venda: R\$ ${produto.precoVenda.toStringAsFixed(2)}'),
            Text('Quantidade: ${produto.quantidade}'),
            Text('Descrição: ${produto.descricao}'),
            Text('Categoria: ${produto.categoria}'),
            Text('Desconto: ${produto.desconto.toStringAsFixed(0)}%'),
            Row(
              children: [
                Icon(produto.ativo ? Icons.check_circle : Icons.cancel,
                    color: produto.ativo ? Colors.green : Colors.red),
                SizedBox(width: 8),
                Text('Ativo'),
              ],
            ),
            Row(
              children: [
                Icon(produto.promocao ? Icons.local_offer : Icons.remove_circle,
                    color: produto.promocao ? Colors.orange : Colors.grey),
                SizedBox(width: 8),
                Text('Promoção'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
