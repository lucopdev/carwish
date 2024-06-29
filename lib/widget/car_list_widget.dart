import 'package:cars/model/car.model.dart';
import 'package:flutter/material.dart';
import 'car_item.dart';

class CarListWidget extends StatelessWidget {
  final List<Car> cars;

  const CarListWidget({required this.cars, super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return CarItem(car: cars[index]);
        },
        childCount: cars.length,
      ),
    );
  }
}
