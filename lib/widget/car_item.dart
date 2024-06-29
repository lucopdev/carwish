import 'package:cars/common/app_routes.dart';
import 'package:cars/model/car.model.dart';
import 'package:flutter/material.dart';

class CarItem extends StatelessWidget {
  final Car car;

  const CarItem({required this.car, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: ListTile(
        contentPadding: const EdgeInsets.all(25),
        title: Text(car.nomeModelo,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Valor: R\$ ${car.valor.toStringAsFixed(3)}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).primaryColor,
            ),
            Text(
              'EU QUERO!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context).pushNamed(AppRoutes.CAR_DETAIL, arguments: car);
        },
      ),
    );
  }
}
