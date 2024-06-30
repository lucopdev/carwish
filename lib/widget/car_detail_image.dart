import 'package:cars/model/car.model.dart';
import 'package:flutter/material.dart';

class CarDetailImage extends StatelessWidget {
  final Car car;
  const CarDetailImage({required this.car, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image.asset('assets/images/car${car.id}.webp'),
        ),
      ],
    );
  }
}
