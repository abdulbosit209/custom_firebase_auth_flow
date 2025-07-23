import 'package:authentication_repository/authentication_repository.dart';
import 'package:custom_firebase_login/auth/sign_up/sign_up_view_model/sign_up_state.dart';
import 'package:custom_firebase_login/core/utils/internal_notification/haptic_feedback/haptic_feedback_listener.dart';
import 'package:custom_firebase_login/core/utils/internal_notification/notify_service.dart';
import 'package:custom_firebase_login/core/utils/internal_notification/toast/toast_event.dart';
import 'package:custom_firebase_login/core/utils/l10n/translate.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class SignUpViewModel extends ValueNotifier<SignUpState> {
  SignUpViewModel({
    required AuthenticationRepository authenticationRepository,
    required NotifyService notifyService,
  }) : _authenticationRepository = authenticationRepository,
       _notifyService = notifyService,
       super(const SignUpState());

  final AuthenticationRepository _authenticationRepository;
  final NotifyService _notifyService;
  final _logger = Logger('$SignUpViewModel');

  void emailChanged(String email) {
    _logger.info('emailChanged $email');
    value = value.withEmail(email);
  }

  void passwordChanged(String password) {
    _logger.info('passwordChanged $password');
    value = value.withPassword(password);
  }

  void confirmedPasswordChanged(String confirmedPassword) {
    _logger.info('confirmedPasswordChanged $confirmedPassword');
    value = value.withConfirmedPassword(confirmedPassword);
  }

  Future<void> signUpFormSubmitted() async {
    _logger.info('signUpFormSubmitted $signUpFormSubmitted');

    if (!value.isValid) return;
    value = value.withSubmissionInProgress();
    try {
      await _authenticationRepository.signUp(
        email: value.email.value,
        password: value.password.value,
      );
      value = value.withSubmissionSuccess();
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      _displayException(
        name: 'SignUpWithEmailAndPasswordFailure',
        error: e.message,
      );
      value = value.withSubmissionFailure(e.message);
    } catch (_) {
      _displayException(name: 'SignUpWithEmailAndPasswordFailure');
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
