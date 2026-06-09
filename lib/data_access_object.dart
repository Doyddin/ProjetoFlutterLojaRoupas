import "package:app_de_roupa/produto.dart";
import "package:flutter/material.dart";
import "package:sqflite/sqflite.dart" as sql;

class DataAccessObject {
  // função que cria a tabela na primeira execução do app
  static Future<void> criarTabelas(sql.Database database) async {
    await database.execute("""
      CREATE TABLE produtos (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        nome TEXT NOT NULL,
        valor FLOAT NOT NULL,
        foto VARCHAR(255) NOT NULL
      );
    """);
    // após criar a tabela, incluímos três itens de exemplo
    await database.execute(
      """
      INSERT INTO produtos (nome, valor, foto) VALUES ('Calça Jeans Cargo', 68.99, 'produto1.webp');""",
    );
    await database.execute(
      """
      INSERT INTO produtos (nome, valor, foto) VALUES ('Blusa Moletom Adidas', 75.99, 'produto2.webp');""",
    );
    await database.execute(
      """
      INSERT INTO produtos (nome, valor, foto) VALUES ('Camiseta Manga Longa Gótica', 6, 'produto3.png');""",
    );

    await database.execute("""
      CREATE TABLE carrinho(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        id_produto INTEGER NOT NULL REFERENCES produtos(id)
      );
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      "appDeRoupas.db",
      version:
          1,
      onCreate: (sql.Database database, int version) async {
        await criarTabelas(database);
      },
    );
  }

  static Future<List<Produto>> obterProdutos() async{
    final db = await DataAccessObject.db();

    List<Map<String, dynamic>> maps = await db.query("produtos", orderBy: "nome");

    return maps.map((map) => Produto.fromMap(map)).toList();
  }

  static Future<List<Produto>> obterProdutosNoCarrinho() async {
    final db = await DataAccessObject.db();

    List<Map<String, dynamic>> maps = await db.rawQuery("""
      SELECT carrinho.id as carrinho_id, produtos.id as id, nome, valor, foto from carrinho 
      join produtos on produtos.id = carrinho.id_produto
      order by carrinho.id  
    """);
    return maps.map((map) => Produto.fromMap(map)).toList();
  }

  static Future<Produto> obterProdutoPorId(int id) async {
    final db = await DataAccessObject.db();
    List<Map<String, dynamic>> resultado = await db.query(
      "produtos",
      where: "id = ?",
      whereArgs: [id],
    );
    return Produto.fromMap(resultado[0]);
  }

  static Future<bool> removerDoCarrinho(int id) async {
    final db = await DataAccessObject.db();
    try {
      await db.delete("carrinho", where: "id = ?", whereArgs: [id]);
      return true;
    } catch (erro) {
      debugPrint("Falha na exclusão: $erro");
      return false;
    }
  }

  static Future<int> adicionarCarrinho(int produtoId) async {
    final db = await DataAccessObject.db();

    final dados = {"id_produto": produtoId};

    final idItemIncluido = await db.insert("carrinho", dados);
    return idItemIncluido;
  }

  static Future<void> excluirCarrinho() async{
    final db = await DataAccessObject.db();

    db.delete("carrinho");
  }
}
