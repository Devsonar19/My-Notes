import 'package:flutter/material.dart';
import 'package:test_application/utilities/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context){
  return showGenericDialog<bool>(
      context: context,
      title: 'Delete',
      content: 'You Sure you want to Delete?',
      optionBuilder: ()=>{
        'Cancel':false,
        'Delete':true,
      }
  ).then(
          (value) => value ?? false);
}
