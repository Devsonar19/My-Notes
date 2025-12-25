import 'package:flutter/material.dart';
import 'package:test_application/utilities/dialogs/generic_dialog.dart';

Future<bool> showLogOutDialog(BuildContext context){
  return showGenericDialog<bool>(
      context: context,
      title: 'Log Out',
      content: 'You Sure you want to Log Out?',
      optionBuilder: ()=>{
        'Cancel':false,
        'Log Out':true,
      }
  ).then(
          (value) => value ?? false);
}
