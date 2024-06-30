import 'package:cars/model/car.model.dart';
import 'package:flutter/material.dart';

class CarDetailPanel extends StatelessWidget {
  Car car;
  CarDetailPanel({required this.car, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Card.outlined(
        elevation: 10,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 30, top: 20, right: 30, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(car.nomeModelo,
                      style: Theme.of(context).textTheme.headlineMedium),
                  Text('Ano: ${car.ano.toString()}',
                      style: Theme.of(context).textTheme.headlineMedium),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Cor: ${car.cor}',
                      style: Theme.of(context).textTheme.headlineMedium),
                  Text('Combustível: ${car.combustivel}',
                      style: Theme.of(context).textTheme.headlineMedium),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Portas: ${car.numPortas}',
                      style: Theme.of(context).textTheme.headlineMedium),
                  Text('Valor: ${car.valor.toStringAsFixed(3)}',
                      style: Theme.of(context).textTheme.headlineMedium),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
