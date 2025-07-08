import 'package:crud_basico/view/commun/components/CustomFormField.dart';
import 'package:crud_basico/view/commun/components/CustomPasswordFormField.dart';
import 'package:crud_basico/view/commun/components/CustomPrimaryButton.dart';
import 'package:flutter/material.dart';
import '../data_base/DatabaseHelper.dart';
import '../HomeScreen.dart';
import 'RegistrationScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    final user = await DatabaseHelper.instance.getUserByEmail(email, password);

    if (user != null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => HomeScreen(userId: user.id!), // <<< PASSA O ID DO USUÁRIO
        ),
            (Route<dynamic> route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email ou senha inválidos!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.note_alt, size: 80, color: Colors.blueAccent),
            const SizedBox(height: 24),
            Text(
              'Bem-vindo de volta!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 48),

            CustomFormField(
              textEditingController: _emailController,
              textInputType: TextInputType.emailAddress,
              labelText: "Email",
              preffixIcon: Icon(Icons.email),
            ),
            const SizedBox(height: 16),

            CustomPasswordFormField(
              textEditingController: _passwordController,
              labelText: 'Senha',
              preffixIcon: Icon(Icons.lock),
            ),
            const SizedBox(height: 32),

            CustomPrimaryButton(text: 'ENTRAR', onPressed: _login),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Não tem uma conta?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                    );
                  },
                  child: const Text('Cadastre-se'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}