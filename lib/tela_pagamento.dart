import 'package:app_de_roupa/data_access_object.dart';
import 'package:app_de_roupa/produto.dart';
import 'package:flutter/material.dart';

class TelaPagamento extends StatefulWidget {
  const TelaPagamento({super.key});

  @override
  State<StatefulWidget> createState() {
    return TelaPagamentoState();
  }
}

class TelaPagamentoState extends State<TelaPagamento> {
  List<Produto> _produtos = [];
  double _valorTotal = 0;

  void atualizarLista() async {
    var produtos = await DataAccessObject.obterProdutosNoCarrinho();
    double valorTotal = 0;

    if (produtos.isNotEmpty) {
      for (final produto in produtos) {
        valorTotal += produto.valor;
      }
    } else {
      valorTotal = 0;
    }

    setState(() {
      _valorTotal = valorTotal;
    });

    setState(() {
      _produtos = produtos;
    });
  }

  void limparCarrinho() async {
    await DataAccessObject.excluirCarrinho();
    atualizarLista();
  }

  @override
  void initState() {
    super.initState();
    atualizarLista();
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
              trailing: Text("Preço: ${_produtos[index].valor}"),
            );
          },
        ),
        Text("Valor total: $_valorTotal"),
        ElevatedButton(
          onPressed: () {
            limparCarrinho();
          },
          child: Text("Pagar por tudo"),
        ),
      ],
    );
  }
}
