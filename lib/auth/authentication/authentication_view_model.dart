import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:custom_firebase_login/core/utils/navigation/router_service.dart';
import 'package:custom_firebase_login/core/utils/navigation/route_data.dart'
    show Path;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

enum AppStatus { authenticated, unauthenticated }

final class AppState extends Equatable {
  const AppState({User user = User.empty})
    : this._(
        status: user == User.empty
            ? AppStatus.unauthenticated
            : AppStatus.authenticated,
        user: user,
      );

  const AppState._({required this.status, this.user = User.empty});

  final AppStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];
}

class AuthenticationViewModel extends ValueNotifier<AppState> {
  AuthenticationViewModel({
    required AuthenticationRepository authenticationRepository,
    required RouterService routerService,
  }) : _authenticationRepository = authenticationRepository,
       _routerService = routerService,
       super(AppState(user: authenticationRepository.currentUser)) {
    _userSubscription = _authenticationRepository.user.listen(_userChanged);
  }

  final AuthenticationRepository _authenticationRepository;
  final RouterService _routerService;
  late final StreamSubscription<User> _userSubscription;
  final _logger = Logger('$AuthenticationViewModel');

  void _userChanged(User user) {
    _logger.info('userChanged $user');
    value = AppState(user: user);

    if (user == User.empty) {
      _routerService.replaceAll([Path(name: '/login_page')]);
    } else {
      _routerService.replaceAll([Path(name: '/')]);
    }
  }

  void onLogOutRequested() {
    _logger.info('onLogOutRequested');
    _authenticationRepository.logOut().ignore();
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    super.dispose();
  }
}
