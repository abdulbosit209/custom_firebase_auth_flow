import 'package:custom_firebase_login/auth/login/login_view_model/login_view_model.dart';
import 'package:flutter/material.dart';

class LoginProvider extends InheritedWidget {
  const LoginProvider({
    required this.loginViewModel,
    required super.child,
    super.key,
  });

  final LoginViewModel loginViewModel;

  static LoginProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LoginProvider>();
  }

  static LoginProvider of(BuildContext context) {
    final LoginProvider? result = maybeOf(context);
    assert(result != null, 'No LoginProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(LoginProvider oldWidget) =>
      loginViewModel != oldWidget.loginViewModel;
}