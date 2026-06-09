import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselImagens extends StatelessWidget {
  CarouselImagens({super.key});

  final List<String> images = [
    'assets/foto1.jpg',
    'assets/foto2.jpg',
    'assets/foto3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        enlargeCenterPage: true,
        viewportFraction: 1.0,
        enableInfiniteScroll: true,
      ),
      items: images.map((image) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            image,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        );
      }).toList(),
    );
  }
}