import 'package:admin_dashboard/ui/shared/labels/custom_labels.dart';
import 'package:flutter/material.dart';

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messageKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String message, bool isError) {
    final snackBar = SnackBar(
      backgroundColor: isError ? Colors.red.withOpacity(0.8) : Colors.green.withOpacity(0.8),
      content: Text(
        message,
        style: CustomLabels.subtitle),
    );

    messageKey.currentState!.showSnackBar(snackBar);
  }
}