import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:producteve/pages/cart/cart_screen.dart';
import 'package:producteve/pages/cart/my_cart.dart';
import 'package:producteve/pages/home/home_screen.dart';
import 'package:producteve/pages/more/more_screen.dart';
import 'package:producteve/pages/my_account/account_screen.dart';

import '../pages/notifications/notifications.dart';

final List<Widget> homeScreenItems = [
  const HomeScreen(),
  const CartScreen(),
  const MoreScreen(),
  // const Notifications(),
  // const MyAccount(),
  const AccountScreen()
];

const gradientGlobal = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xffFEC37B),
    Color(0xffFF4184),
  ],
);
const lifhtGradientGlobal = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color.fromARGB(255, 252, 200, 136),
    Color.fromARGB(255, 248, 95, 149),
  ],
);

class Utils {
  Size getScreenSize() {
    return MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
  }

  Future<Uint8List?> pickImage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    return file!.readAsBytes();
  }

  String getUid() {
    return (100000 + Random().nextInt(10000)).toString();
  }
}

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset('assets/106611-kitty-loading.json'),
    );
  }
}
