import 'dart:async';

import 'package:custom_firebase_login/config/locator_config.dart';
import 'package:custom_firebase_login/core/abstractions/logging_abstraction.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

/// Represents different states of app initialization
sealed class AppState {
  const AppState();
}

class InitializingApp extends AppState {
  const InitializingApp();
}

class AppInitialized extends AppState {
  const AppInitialized();
}

class AppInitializationError extends AppState {
  final Object error;
  final StackTrace stackTrace;
  const AppInitializationError(this.error, this.stackTrace);
}

/// ViewModel responsible for handling app startup and initialization
class StartupViewModel {
  StartupViewModel({LoggingAbstraction? loggingAbstraction})
    : _loggingAbstraction = loggingAbstraction ?? LoggingAbstraction();

  final appStateNotifier = ValueNotifier<AppState>(const InitializingApp());

  final LoggingAbstraction _loggingAbstraction;
  late StreamSubscription<LogRecord> loggingSubscription;

  Future<void> initializeApp() async {
    appStateNotifier.value = const InitializingApp();
    try {
      setup();
      loggingSubscription = _loggingAbstraction.initializeLogging();
      await locator.allReady();
      appStateNotifier.value = const AppInitialized();
    } catch (e, st) {
      appStateNotifier.value = AppInitializationError(e, st);
    }
  }

  Future<void> retryInitialization() async {
    locator.reset();
    await initializeApp();
  }

  void dispose() {
    appStateNotifier.dispose();
    loggingSubscription.cancel();
  }
}
