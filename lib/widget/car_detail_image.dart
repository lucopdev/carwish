import 'package:cars/model/car.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CarDetailImage extends StatelessWidget {
  final Car car;
  const CarDetailImage({required this.car, super.key});

  Future<bool> _doesAssetExist(String path) async {
    try {
      await rootBundle.load(path);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder<bool>(
            future: _doesAssetExist('assets/images/car${car.id}.webp'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError || !snapshot.data!) {
                return Image.asset('assets/images/not_found.png');
              } else {
                return Image.asset('assets/images/car${car.id}.webp');
              }
            },
          ),
        ),
      ],
    );
  }
}
