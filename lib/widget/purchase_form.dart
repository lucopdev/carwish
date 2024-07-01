import 'dart:async';

import 'package:cars/common/app_routes.dart';
import 'package:cars/common/my_colors.dart';
import 'package:cars/model/car.model.dart';
import 'package:cars/model/car_user.model.dart';
import 'package:cars/model/user.model.dart';
import 'package:cars/services/car_user.service.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:cars/common/get_input_decoration.dart';
import 'package:flutter/material.dart';

class PurchaseForm extends StatefulWidget {
  final Car car;
  const PurchaseForm({required this.car, super.key});

  @override
  State<PurchaseForm> createState() => _PurchaseFormState();
}

class _PurchaseFormState extends State<PurchaseForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isFormValidated = false;
  bool _isFormSubmited = false;
  bool _isLoading = false;

  String? validateName(String? value) {
    if (value!.isEmpty || RegExp(r'[0-9]').hasMatch(value)) {
      return 'Preencha seu nome';
    }

    return null;
  }

  String? validatePhone(String? value) {
    final RegExp phoneRegex = RegExp(r'^\(\d{2}\)\s\d{5}-\d{4}$');
    if (value!.isEmpty || !phoneRegex.hasMatch(value)) {
      return 'Não esqueça o telefone';
    }

    return null;
  }

  String? validateEmail(String? value) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value!)) {
      return 'Digite um email válido!';
    }

    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print('Formulário válido');

      // Gerar IDs manualmente usando timestamp atual
      final userId = DateTime.now()
          .millisecondsSinceEpoch; // ID único baseado no timestamp atual
      final carUserId = DateTime.now()
          .microsecondsSinceEpoch; // ID único baseado no timestamp atual

      CarUserService()
          .insertCarUser(
        CarUser(
          id: carUserId, // Gerar ID único para CarUser
          timestampCadastro: DateTime.now().millisecondsSinceEpoch,
          user: User(
            id: userId, // Atribuir ID gerado ao usuário
            name: _nameController.text,
            phone: _phoneController.text,
            email: _emailController.text,
          ),
          car: widget.car,
        ),
      )
          .then((_) {
        setState(() {
          _isLoading = true;
          _isFormSubmited = true;
        });
        Timer(const Duration(seconds: 3), () {
          _nameController.clear();
          _phoneController.clear();
          _emailController.clear();
          setState(() {
            _isLoading = false;
          });
        });
      }).catchError((e) {
        print('Erro ao submeter formulário: $e');
      });
    } else {
      print('Formulário inválido');
    }
  }

  void _checkFormValidated() {
    _formKey.currentState!.validate();
    if (_isFormValidated != _formKey.currentState!.validate()) {
      setState(() {
        _isFormValidated = _formKey.currentState!.validate();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_checkFormValidated);
    _phoneController.addListener(_checkFormValidated);
    _emailController.addListener(_checkFormValidated);
  }

  @override
  void dispose() {
    _nameController.removeListener(_checkFormValidated);
    _phoneController.removeListener(_checkFormValidated);
    _emailController.removeListener(_checkFormValidated);

    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var phoneMaskFormatter = MaskTextInputFormatter(
        mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: _isFormSubmited && !_isLoading
          ? Column(
              children: <Widget>[
                const SizedBox(height: 15),
                Text(
                  'Obrigado!',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(MyColors.drawerTheme),
                    padding: const MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).pushNamed(AppRoutes.HOME);
                    });
                  },
                  child: Text(
                    'Voltar',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ],
            )
          : Column(
              children: <Widget>[
                const SizedBox(height: 15),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _nameController,
                  decoration: getInputDecoration('Nome'),
                  validator: validateName,
                  onChanged: (value) => _checkFormValidated(),
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
                  onChanged: (value) => _checkFormValidated(),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: getInputDecoration('E-mail'),
                  validator: validateEmail,
                  onChanged: (value) => _checkFormValidated(),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: const MaterialStatePropertyAll(
                        Size(double.infinity, 50),
                      ),
                      backgroundColor: _isFormValidated
                          ? MaterialStatePropertyAll(MyColors.drawerTheme)
                          : const MaterialStatePropertyAll(Colors.grey),
                      padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      ),
                    ),
                    onPressed: _isFormValidated ? _submitForm : null,
                    child: (_isLoading && _isFormSubmited)
                        ? CircularProgressIndicator(
                            color: MyColors.darkTextTheme,
                          )
                        : Text(
                            'Sim, esse é o carro!',
                            style: Theme.of(context).textTheme.headlineMedium,
                          )),
              ],
            ),
    );
  }
}
