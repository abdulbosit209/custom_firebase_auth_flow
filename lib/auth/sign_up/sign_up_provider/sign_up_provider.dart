import 'package:custom_firebase_login/auth/sign_up/sign_up_view_model/sign_up_view_model.dart';
import 'package:flutter/material.dart';

class SignUpProvider extends InheritedWidget {
  const SignUpProvider({
    required this.signUpViewModel,
    required super.child,
    super.key,
  });

  final SignUpViewModel signUpViewModel;

  static SignUpProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SignUpProvider>();
  }

  static SignUpProvider of(BuildContext context) {
    final SignUpProvider? result = maybeOf(context);
    assert(result != null, 'No SignUpProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(SignUpProvider oldWidget) =>
      signUpViewModel != oldWidget.signUpViewModel;
}