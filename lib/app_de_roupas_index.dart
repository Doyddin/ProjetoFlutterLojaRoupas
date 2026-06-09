import 'package:app_de_roupa/carrinho.dart';
import 'package:app_de_roupa/lista_de_roupas.dart';
import 'package:app_de_roupa/tela_pagamento.dart';
import 'package:flutter/material.dart';
import 'data_access_object.dart';

class AppDeRoupasIndex extends StatefulWidget {
  const AppDeRoupasIndex({super.key});
  
  @override
  State<StatefulWidget> createState() {
    return _AppDeRoupasIndexState();
  }
}

class _AppDeRoupasIndexState extends State<AppDeRoupasIndex> {
  int _selectedIndex = 0;
  int _quantidadeDeItens = 0;

  void atualizarQuantidadeItens() async {
    final produtos = await DataAccessObject.obterProdutosNoCarrinho();

    setState(() {
      _quantidadeDeItens = produtos.length;
    });
  }

  static final List<Widget> _widgetOptions = <Widget>[
    ListaDeRoupas(),
    Carrinho(),
    TelaPagamento(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

   @override
  void initState() {
    super.initState();
    atualizarQuantidadeItens();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App de Modas"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Center(child: _widgetOptions[_selectedIndex]),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              child: Text("Menu"),
            ),
            ListTile(
              title: Text("Início"),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Carrinho"),
              selected: _selectedIndex == 1,
              trailing: Text(
                _quantidadeDeItens.toString(),
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Pagamento"),
              selected: _selectedIndex == 2,
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
