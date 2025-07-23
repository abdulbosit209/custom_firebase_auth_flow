import 'package:authentication_repository/authentication_repository.dart';
import 'package:custom_firebase_login/auth/login/login_view_model/login_view_state.dart';
import 'package:custom_firebase_login/core/utils/internal_notification/haptic_feedback/haptic_feedback_listener.dart';
import 'package:custom_firebase_login/core/utils/internal_notification/notify_service.dart';
import 'package:custom_firebase_login/core/utils/internal_notification/toast/toast_event.dart';
import 'package:custom_firebase_login/core/utils/l10n/translate.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class LoginViewModel extends ValueNotifier<LoginState> {
  LoginViewModel({
    required AuthenticationRepository authenticationRepository,
    required NotifyService notifyService,
  }) : _authenticationRepository = authenticationRepository,
       _notifyService = notifyService,
       super(const LoginState());

  final AuthenticationRepository _authenticationRepository;
  final NotifyService _notifyService;
  final _logger = Logger('$LoginViewModel');

  void emailChanged(String email) {
    _logger.info('emailChanged $email');
    value = value.withEmail(email);
  }

  void passwordChanged(String password) {
    _logger.info('passwordChanged $passwordChanged');
    value = value.withPassword(password);
  }

  Future<void> logInWithCredentials() async {
    _logger.info('logInWithCredentials');

    if (!value.isValid) return;
    value = value.withSubmissionInProgress();
    try {
      await _authenticationRepository.logInWithEmailAndPassword(
        email: value.email.value,
        password: value.password.value,
      );
      value = value.withSubmissionSuccess();
    } on LogInWithEmailAndPasswordFailure catch (e) {
      _displayException(name: 'LogInWithEmailAndPasswordFailure', error: e.message);
      value = value.withSubmissionFailure(e.message);
    } catch (_) {
      _displayException(name: 'LogInWithEmailAndPasswordFailure');
      value = value.withSubmissionFailure();
    }
  }

  Future<void> logInWithGoogle() async {
    _logger.info('logInWithGoogle');

    value = value.withSubmissionInProgress();
    try {
      await _authenticationRepository.logInWithGoogle();
      value = value.withSubmissionSuccess();
    } on LogInWithGoogleFailure catch (e) {
      _displayException(name: 'LogInWithGoogleFailure', error: e.message);
      value = value.withSubmissionFailure(e.message);
    } catch (_) {
      _displayException(name: 'LogInWithGoogleFailure');
      value = value.withSubmissionFailure();
    }
  }

  void _displayException({required String name, String? error}) {
    _logger.shout('$name failure: $error');
    _notifyService.setToastEvent(
      ToastEventError(message: error ?? Translate.current.errorGeneric),
    );
    _notifyService.setHapticFeedbackEvent(HapticFeedbackEvent.error);
  }
}
