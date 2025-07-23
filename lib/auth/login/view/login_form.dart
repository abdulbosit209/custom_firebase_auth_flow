import 'package:custom_firebase_login/auth/login/login_provider/login_provider.dart';
import 'package:custom_firebase_login/config/locator_config.dart';
import 'package:custom_firebase_login/core/utils/navigation/router_service.dart';
import 'package:custom_firebase_login/core/utils/navigation/route_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -1 / 3),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _EmailInput(),
            const SizedBox(height: 8),
            _PasswordInput(),
            const SizedBox(height: 8),
            _LoginButton(),
            const SizedBox(height: 8),
            _GoogleLoginButton(),
            const SizedBox(height: 4),
            _SignUpButton(),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginProvider = LoginProvider.of(context).loginViewModel;

    return ValueListenableBuilder(
      valueListenable: loginProvider,
      builder: (context, state, _) {
        return TextField(
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) => loginProvider.emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'email',
            helperText: '',
            errorText: state.email.displayError != null
                ? 'invalid email'
                : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginProvider = LoginProvider.of(context).loginViewModel;

    return ValueListenableBuilder(
      valueListenable: loginProvider,
      builder: (context, state, _) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) => loginProvider.passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'password',
            helperText: '',
            errorText: state.password.displayError != null
                ? 'invalid password'
                : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginProvider = LoginProvider.of(context).loginViewModel;

    return ValueListenableBuilder(
      valueListenable: loginProvider,
      builder: (context, state, _) {
        final isInProgress = state.status.isInProgress;

        if (isInProgress) return const CircularProgressIndicator();

        return ElevatedButton(
          key: const Key('loginForm_continue_raisedButton'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: state.isValid
              ? () => loginProvider.logInWithCredentials()
              : null,
          child: const Text('LOGIN'),
        );
      },
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginProvider = LoginProvider.of(context).loginViewModel;

    return ElevatedButton.icon(
      key: const Key('loginForm_googleLogin_raisedButton'),
      label: const Text('SIGN IN WITH GOOGLE'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      icon: const Icon(FontAwesomeIcons.google),
      onPressed: () => loginProvider.logInWithGoogle(),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('loginForm_createAccount_flatButton'),
      onPressed: () =>
          locator<RouterService>().goTo(Path(name: '/sign_up_page')),
      child: Text('CREATE ACCOUNT'),
    );
  }
}
