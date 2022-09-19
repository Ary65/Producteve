import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class MyCart extends StatelessWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Lottie.asset(
              'assets/71390-shopping-cart-loader.json',
            ),
          ),
          Text(
            'Your Cart is Empty',
            style: GoogleFonts.sahitya(
              fontSize: 30,
            ),
          )
        ],
      ),
    );
  }
}
