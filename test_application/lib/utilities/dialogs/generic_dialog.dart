import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

typedef DialogOptionBuilder<T>= Map<String, T?> Function();

Future<T?> showGenericDialog<T>({
 required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder optionBuilder,
}){
  final options= optionBuilder();
  return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          contentPadding: EdgeInsets.all(25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
         backgroundColor: HexColor('D1D8BE'),
         title: Text(
             title,
           style: TextStyle(
             fontWeight: FontWeight.bold,
             fontSize: 30,
           ),
         ),
         content: Text(
             content,
           style: TextStyle(
             fontWeight: FontWeight.bold,
             fontSize: 17,
           ),
         ),
         actions: options.keys.map((optionTitle){
           final T value = options[optionTitle];
           return TextButton(
               onPressed: (){
                if(value!=null){
                  Navigator.of(context).pop(value);
                }else{
                  Navigator.of(context).pop();
                }
               },
                child: Text(
                   optionTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
              ),
           );
         }).toList(),
        );
      },
  );

}