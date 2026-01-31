import 'package:flutter/material.dart';
import 'package:test_application/utilities/dialogs/generic_dialog.dart';

Future<void> basicInfoForDelete(BuildContext context){
  return showGenericDialog<void>(
      context: context,
      title: 'Information',
      content: 'Long Press your note to Delete',
      optionBuilder: ()=>{
        'Ok':null,
      });
}