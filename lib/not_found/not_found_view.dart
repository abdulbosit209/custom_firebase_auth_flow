import 'package:custom_firebase_login/config/locator_config.dart';
import 'package:custom_firebase_login/core/ui/app_theme.dart';
import 'package:custom_firebase_login/core/utils/l10n/translate_extension.dart';
import 'package:custom_firebase_login/core/utils/navigation/router_service.dart';
import 'package:custom_firebase_login/not_found/not_found_view_model.dart';
import 'package:flutter/material.dart';

class NotFoundView extends StatefulWidget {
  const NotFoundView({super.key});

  @override
  State<NotFoundView> createState() => _NotFoundViewState();
}

class _NotFoundViewState extends State<NotFoundView> {
  late final NotFoundViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = NotFoundViewModel(routerService: locator<RouterService>());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(context.spacing.xl),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                context.translate.notFoundTitle,
                style: context.textStyles.xxxl,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.spacing.md),
              Text(
                context.translate.notFoundMessage,
                style: context.textStyles.standard,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.spacing.xl),
              OutlinedButton(
                onPressed: _viewModel.navigateToHome,
                child: Text(context.translate.notFoundGoHome),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
