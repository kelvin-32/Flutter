import 'package:cadastro_banco_dados/model/produto_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ProductDatabase {
  static final ProductDatabase _instance = ProductDatabase._internal();
  factory ProductDatabase() => _instance;
  ProductDatabase._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  _initDB() async {
    final dbcaminho = await getDatabasesPath();
    final caminhoCompleto = join(dbcaminho, 'produtos.db');

    return await openDatabase(
      caminhoCompleto,
      version: 1,
      onCreate: (db, version) async {
        return await db.execute('''
          CREATE TABLE produtos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT NOT NULL,
            preco_compra REAL NOT NULL,
            preco_venda REAL NOT NULL,
            quantidade INTEGER NOT NULL,
            categoria TEXT NOT NULL,
            descricao TEXT,
            imagem TEXT,
            ativo INTEGER NOT NULL DEFAULT 1,
            em_promocao INTEGER NOT NULL DEFAULT 0,
            desconto REAL NOT NULL DEFAULT 0.0,
            data_cadastro TEXT NOT NULL DEFAULT (datetime('now')
            
          )
        ''');
      },
    );
  }

  Future<int> insertProduct(ProdutoModel productModel) async {
    final db = await database;
    final map = productModel.toMap();
    return await db.insert('produtos', produto.toMap());
  }

  findAllProducts() {}
}
