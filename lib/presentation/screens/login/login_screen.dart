import 'package:flutter/material.dart';
import 'package:vinnovatelabzsalmankv/presentation/screens/login/widgets.dart';

// ignore: must_be_immutable
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 239, 239, 239),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [LoginWidget().whiteContainer(context: context)],
        ),
      ),
    );
  }
}
