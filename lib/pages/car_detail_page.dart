import 'package:cars/model/car.model.dart';
import 'package:cars/widget/app_bar_custom.dart';
import 'package:cars/widget/car_detail_widget.dart';
import 'package:cars/widget/purchase_form.dart';
import 'package:flutter/material.dart';

class CarDetailPage extends StatelessWidget {
  const CarDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final car = ModalRoute.of(context)!.settings.arguments as Car;

    return Scaffold(
      appBar: buildCustomAppBar(
          context: context, title: car.nomeModelo, showBackButton: true),
      body: Column(
        children: [
          CarDetailWidget(car: car),
          const Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: PurchaseForm(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
