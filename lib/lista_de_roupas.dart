import 'package:app_de_roupa/carousel_imagens.dart';
import 'package:flutter/material.dart';

class ListaDeRoupas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselImagens(),
        SizedBox(
          height: 70,
          width: 300,
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(image: AssetImage("produto1.webp")),
                Text("Calça Jeans Cargo"),
                Icon(Icons.shopping_bag)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
