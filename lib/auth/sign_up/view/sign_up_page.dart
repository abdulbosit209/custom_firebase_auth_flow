import 'package:authentication_repository/authentication_repository.dart';
import 'package:custom_firebase_login/auth/sign_up/sign_up_provider/sign_up_provider.dart';
import 'package:custom_firebase_login/auth/sign_up/sign_up_view_model/sign_up_view_model.dart';
import 'package:custom_firebase_login/auth/sign_up/view/sign_up_form.dart';
import 'package:custom_firebase_login/config/locator_config.dart';
import 'package:custom_firebase_login/core/utils/internal_notification/notify_service.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final SignUpViewModel signUpViewModel;

  @override
  void initState() {
    super.initState();
    signUpViewModel = SignUpViewModel(
      authenticationRepository: locator<AuthenticationRepository>(),
      notifyService: locator<NotifyService>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SignUpProvider(
          signUpViewModel: signUpViewModel,
          child: const SignUpForm(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    signUpViewModel.dispose();
    super.dispose();
  }
}
