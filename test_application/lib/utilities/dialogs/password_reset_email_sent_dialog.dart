import 'package:flutter/material.dart';
import 'package:test_application/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context){
  return showGenericDialog<void>(
      context: context,
      title: 'Password Reset',
      content: 'Password reset link sent! Check your email For More Info!',
      optionBuilder: () => {
        'Ok': null,
      }
  );
}