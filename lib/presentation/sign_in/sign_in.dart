import 'package:flutter/material.dart';

import 'package:tmdb/application/app_state.dart';

/// The sign-in screen.
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _canLogin = false;

  void _userNameChanged() => setState(() {
    _canLogin = _usernameController.value.text.isNotEmpty;
  });

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_userNameChanged);
  }

  void _login() {
    AppState.of(context).login(
      _usernameController.value.text,
      _passwordController.value.text,
    );
    _usernameController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          child: Container(
            constraints: BoxConstraints.loose(const Size(600, 600)),
            padding: const EdgeInsets.all(32),
            child: _form(context),
          ),
        ),
      ),
    );
  }

  Widget _form(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('Welcome', style: Theme.of(context).textTheme.headlineLarge),
        TextField(
          decoration: const InputDecoration(labelText: 'Username'),
          controller: _usernameController,
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
          controller: _passwordController,
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextButton(
            style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.displaySmall),
            onPressed: _canLogin ? _login : null,
            child: const Text('Sign in'),
          ),
        ),
      ],
    );
  }
}
