import 'package:custom_firebase_login/auth/authentication/authentication_view_model.dart';
import 'package:custom_firebase_login/config/locator_config.dart';
import 'package:custom_firebase_login/home/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              locator<AuthenticationViewModel>().onLogOutRequested();
            },
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: locator<AuthenticationViewModel>(),
        builder: (context, state, _) {
          return Align(
            alignment: const Alignment(0, -1 / 3),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Avatar(photo: state.user.photo),
                const SizedBox(height: 4),
                Text(state.user.email ?? '', style: textTheme.titleLarge),
                const SizedBox(height: 4),
                Text(state.user.name ?? '', style: textTheme.headlineSmall),
              ],
            ),
          );
        }
      ),
    );
  }
}