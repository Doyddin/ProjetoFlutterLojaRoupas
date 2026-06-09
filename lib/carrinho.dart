import 'package:app_de_roupa/data_access_object.dart';
import 'package:app_de_roupa/produto.dart';
import 'package:flutter/material.dart';

class Carrinho extends StatefulWidget {
  const Carrinho({super.key});

  @override
  State<StatefulWidget> createState() {
    return CarrinhoState();
  }
}

class CarrinhoState extends State<Carrinho> {
  List<Produto> _produtos = [];

  void pegarCarrinho() async {
    List<Produto> produtos = await DataAccessObject.obterProdutosNoCarrinho();

    setState(() {
      _produtos = produtos;
    });
  }

  void removerDoCarrinho(int id) async {
    await DataAccessObject.removerDoCarrinho(id);
    pegarCarrinho();
  }

  @override
  void initState() {
    super.initState();
    pegarCarrinho();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true, // necessária quando o ListView está numa Column
          itemCount: _produtos.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Image.asset("assets/${_produtos[index].imagem}"),
              title: Text(_produtos[index].nome),
              subtitle: Text("Preço: ${_produtos[index].valor}"),
              trailing: IconButton(
                onPressed: () {
                  removerDoCarrinho(_produtos[index].carrinhoId);
                },
                icon: Icon(Icons.delete),
              ),
            );
          },
        ),
      ],
    );
  }
}
