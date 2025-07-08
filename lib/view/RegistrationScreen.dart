import 'package:crud_basico/view/commun/components/CustomFormField.dart';
import 'package:crud_basico/view/commun/components/CustomPasswordFormField.dart';
import 'package:crud_basico/view/commun/components/CustomPrimaryButton.dart';
import 'package:flutter/material.dart';
import '../data_base/DatabaseHelper.dart';
import '../model/user_model.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (_passwordController.text == _confirmPasswordController.text) {
      final newUser = User(
        email: _emailController.text,
        password: _passwordController.text,
      );

      await DatabaseHelper.instance.createUser(newUser);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastro realizado com sucesso!')),
      );
      Navigator.pop(context);
    } else {
      // Mostra uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('As senhas não coincidem!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crie sua Conta'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),
            Text(
              'Preencha os dados abaixo',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 48),

            CustomFormField(
              textEditingController: _emailController,
              textInputType: TextInputType.emailAddress,
              labelText: 'Email',
              preffixIcon: (Icon(Icons.email)),
            ),
            const SizedBox(height: 16),

            CustomPasswordFormField(
              textEditingController: _passwordController,
              labelText: 'Senha',
              preffixIcon: Icon(Icons.lock),
            ),
            const SizedBox(height: 16),

            CustomPasswordFormField(
              textEditingController: _confirmPasswordController,
              labelText: 'Confirmar Senha',
              preffixIcon: Icon(Icons.lock_outline),
            ),
            const SizedBox(height: 32),

            CustomPrimaryButton(text: 'CADASTRAR', onPressed: _register)
          ],
        ),
      ),
    );
  }
}