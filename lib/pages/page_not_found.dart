import 'package:cars/widget/app_bar_custom.dart';
import 'package:flutter/material.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          buildCustomAppBar(context: context, title: 'Pagina não encontrada'),
      body: Center(
        child: Column(
          children: [
            Text('Olá! A página que você buscou não existe no nosso sistema :(',
                style: Theme.of(context).textTheme.headlineMedium),
            Text('Desculpe pelo transtorno!',
                style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
    );
  }
}
