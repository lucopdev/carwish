import 'package:cars/model/car.model.dart';
import 'package:cars/widget/app_bar_custom.dart';
import 'package:cars/widget/car_detail_image.dart';
import 'package:cars/widget/car_detail_panel.dart';
import 'package:cars/widget/purchase_form.dart';
import 'package:flutter/material.dart';

class CarDetailPage extends StatelessWidget {
  const CarDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _car = ModalRoute.of(context)!.settings.arguments as Car;

    return Scaffold(
      appBar: buildCustomAppBar(
          context: context, title: _car.nomeModelo, showBackButton: true),
      body: Column(
        children: [
          CarDetailImage(car: _car),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CarDetailPanel(car: _car),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: PurchaseForm(car: _car),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
