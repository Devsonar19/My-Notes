import 'package:flutter/material.dart';
import 'package:test_application/constants/routes.dart';
import 'package:test_application/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification View'),
      ),
      body: Column(children: [
        const Text("Email Verification Link has been Delivered, Please open link to Verify Account"),
        const Text("If you haven't, Please click Below Button"),
        TextButton(onPressed: () async {
          await AuthService.firebase().sendEmailVerification();
        }, child: const Text('Send email verification')
        ),
        TextButton(
            onPressed: () async{
              await AuthService.firebase().logOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute,
                  (route) => false
              );
            },
            child: const Text('Restart'),
        )
      ],
      ),
    );
  }
}