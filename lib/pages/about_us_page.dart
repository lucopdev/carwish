import 'package:cars/widget/app_bar_custom.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context: context, title: 'Sobre a Carwish', showBackButton: true),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text('Bem-vindo à Carwish!',
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 5.0),
                const Text(
                    'Somos uma plataforma dedicada a facilitar a sua busca pelo carro ideal. Nosso objetivo é oferecer uma experiência simples e eficiente para que você possa encontrar e expressar interesse nos melhores veículos disponíveis no mercado.'),
                const SizedBox(height: 20.0),
                Text('Nossa Missão',
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 5.0),
                const Text(
                    'Ajudar você a encontrar o carro dos seus sonhos com facilidade e conveniência. Sabemos que a compra de um veículo é uma decisão importante, e estamos aqui para tornar esse processo mais acessível e descomplicado.'),
                const SizedBox(height: 20.0),
                Text('Como Funciona',
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 5.0),
                const Text(
                    '- Explorar Carros: Navegue pela nossa extensa lista de carros disponíveis e descubra detalhes sobre cada modelo.'),
                const Text(
                    '- Expressar Interesse: Encontrou um carro que gostou? Basta selecionar e pressionar o botão "Eu Quero" para registrar seu interesse.'),
                const Text(
                    '- Registro de Leads: Armazenamos suas intenções de compra de forma segura e periódica enviamos essas informações para nossos parceiros, garantindo que você tenha a melhor chance de conseguir o carro desejado.'),
                const SizedBox(height: 20.0),
                Text('Nossa Equipe',
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 5.0),
                const Text(
                    'Somos uma equipe apaixonada por carros e tecnologia, comprometida em proporcionar a melhor experiência possível para nossos usuários. '),
                const SizedBox(height: 20.0),
                Text('Contato',
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 5.0),
                const Text(
                    'Se tiver alguma dúvida ou precisar de ajuda, não hesite em nos contatar. Estamos aqui para ajudar você a encontrar o carro perfeito!'),
                const Text(
                    'Obrigado por escolher o CarFinder - Intenção de Compra. Esperamos que você tenha uma excelente experiência!'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
