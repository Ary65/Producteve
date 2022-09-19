import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/5146-notifications.json',
        ),
      ),
    );
  }
}
