import 'package:custom_firebase_login/core/utils/internal_notification/haptic_feedback/haptic_feedback_listener.dart';
import 'package:custom_firebase_login/core/utils/internal_notification/toast/toast_view.dart';
import 'package:flutter/material.dart';

class InternalNotificationListener extends StatelessWidget {
  const InternalNotificationListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return HapticFeedbackListener(child: ToastView(child: child));
  }
}