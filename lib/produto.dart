class Produto {
  int id = 0;
  String nome;
  double valor;
  String imagem;
  int carrinhoId;

  Produto({required this.id, required this.nome, required this.valor, required this.imagem, required this.carrinhoId});

  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      id: map["id"],
      nome: map["nome"], 
      valor: map["valor"],
      imagem: map["foto"],
      carrinhoId: map["carrinho_id"] ?? 0
    );
  }
}
