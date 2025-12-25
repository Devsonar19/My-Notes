import 'package:flutter/cupertino.dart';
import 'package:test_application/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
){
  return showGenericDialog<void>(
  context: context,
  title: 'An Error Occurred',
  content: text,
  optionBuilder: ()=>{
    'OK':null,
  },
);
}