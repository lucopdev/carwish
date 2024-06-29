import 'package:cars/common/my_colors.dart';
import 'package:cars/model/user.model.dart';
import 'package:cars/services/user_service.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:cars/common/get_input_decoration.dart';
import 'package:flutter/material.dart';

class PurchaseForm extends StatefulWidget {
  const PurchaseForm({super.key});

  @override
  State<PurchaseForm> createState() => _PurchaseFormState();
}

class _PurchaseFormState extends State<PurchaseForm> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? validateName(String? value) {
    if (value!.isEmpty || RegExp(r'[0-9]').hasMatch(value)) {
      return 'Ops, esqueceu de preencher seu nome?';
    }

    return null;
  }

  String? validatePhone(String? value) {
    final RegExp phoneRegex = RegExp(r'^\(\d{2}\)\s\d{5}-\d{4}$');
    if (value!.isEmpty || !phoneRegex.hasMatch(value)) {
      return 'Ih, o telefone está inválido!';
    }

    return null;
  }

  String? validateEmail(String? value) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value!)) {
      return 'Por favor, digite um email válido!';
    }

    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print('Formulário válido');
      UserService().insertUser(
        User(
          name: _nameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
        ),
      );
    } else {
      print('Formulário inválido');
    }
  }

  @override
  Widget build(BuildContext context) {
    var phoneMaskFormatter = MaskTextInputFormatter(
        mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 15),
          TextFormField(
            controller: _nameController,
            decoration: getInputDecoration('Nome'),
            validator: validateName,
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            keyboardType: TextInputType.phone,
            inputFormatters: [phoneMaskFormatter],
            controller: _phoneController,
            decoration: getInputDecoration('(00) 00000-0000'),
            validator: validatePhone,
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: _emailController,
            decoration: getInputDecoration('E-mail'),
            validator: validateEmail,
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(MyColors.drawerTheme),
              padding: const MaterialStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              ),
            ),
            onPressed: () => _submitForm(),
            child: Text(
              'Sim, esse é o carro!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ],
      ),
    );
  }
}
