import 'package:authentication_repository/authentication_repository.dart';
import 'package:custom_firebase_login/auth/login/login_provider/login_provider.dart';
import 'package:custom_firebase_login/auth/login/login_view_model/login_view_model.dart';
import 'package:custom_firebase_login/auth/login/view/login_form.dart';
import 'package:custom_firebase_login/config/locator_config.dart';
import 'package:custom_firebase_login/core/utils/internal_notification/notify_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginViewModel _loginViewModel;

  @override
  void initState() {
    super.initState();
    _loginViewModel = LoginViewModel(
      authenticationRepository: locator<AuthenticationRepository>(),
      notifyService: locator<NotifyService>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: LoginProvider(
          loginViewModel: _loginViewModel,
          child: LoginForm(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginViewModel.dispose();
    super.dispose();
  }
}
