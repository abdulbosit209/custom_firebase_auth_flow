import 'package:custom_firebase_login/auth/sign_up/sign_up_provider/sign_up_provider.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -1 / 3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _EmailInput(),
          const SizedBox(height: 8),
          _PasswordInput(),
          const SizedBox(height: 8),
          _ConfirmPasswordInput(),
          const SizedBox(height: 8),
          _SignUpButton(),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final signUpProvider = SignUpProvider.of(context).signUpViewModel;

    return ValueListenableBuilder(
      valueListenable: signUpProvider,
      builder: (context, state, _) {
        return TextField(
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) => signUpProvider.emailChanged(email),
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
    final signUpProvider = SignUpProvider.of(context).signUpViewModel;

    return ValueListenableBuilder(
      valueListenable: signUpProvider,
      builder: (context, state, child) {
        return TextField(
          key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (password) => signUpProvider.passwordChanged(password),
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

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final signUpProvider = SignUpProvider.of(context).signUpViewModel;

    return ValueListenableBuilder(
      valueListenable: signUpProvider,
      builder: (context, state, _) {
        return TextField(
          key: const Key('signUpForm_confirmedPasswordInput_textField'),
          onChanged: (confirmPassword) =>
              signUpProvider.confirmedPasswordChanged(confirmPassword),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'confirm password',
            helperText: '',
            errorText: state.confirmedPassword.displayError != null
                ? 'passwords do not match'
                : null,
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final signUpProvider = SignUpProvider.of(context).signUpViewModel;

    return ValueListenableBuilder(
      valueListenable: signUpProvider,
      builder: (context, state, _) {
        final isInProgress = state.status.isInProgress;

        if (isInProgress) return const CircularProgressIndicator();

        return ElevatedButton(
          key: const Key('signUpForm_continue_raisedButton'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: Colors.orangeAccent,
          ),
          onPressed: state.isValid
              ? () => signUpProvider.signUpFormSubmitted()
              : null,
          child: const Text('SIGN UP'),
        );
      },
    );
  }
}
