class Product {
  String titulo;
  double preco;
  String descricao;
  String categoria;
  String imagemUrl;

  Product({
    required this.titulo,
    required this.preco,
    required this.descricao,
    required this.categoria,
    required this.imagemUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'preco': preco,
      'descricao': descricao,
      'categoria': categoria,
      'imagemUrl': imagemUrl,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      titulo: map['titulo'],
      preco: map['preco'] is double
          ? map['preco']
          : double.tryParse(map['preco'].toString()) ?? 0.0,
      descricao: map['descricao'],
      categoria: map['categoria'],
      imagemUrl: map['imagemUrl'],
    );
  }
}
