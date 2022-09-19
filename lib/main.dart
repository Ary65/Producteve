import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:producteve/layout/layout_screen.dart';
import 'package:producteve/pages/auth/animated/animated_login_screen.dart';
import 'package:producteve/providers/user_details_provider.dart';
import 'package:producteve/utils/color_themes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent,
  // ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserDetailsProvider())],
      child: MaterialApp(
        title: 'Product Eve',
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: backgroundColor,
          useMaterial3: true,
        ),
        // theme: ThemeData(
        //   textTheme: GoogleFonts.alegreyaSansScTextTheme(),
        // ).copyWith(
        //   scaffoldBackgroundColor: backgroundColor,

        // ),
        // theme: ThemeData.light().copyWith(
        //   scaffoldBackgroundColor: backgroundColor,
        //   useMaterial3: true,
        // ),
        debugShowCheckedModeBanner: false,

        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, AsyncSnapshot<User?> user) {
            if (user.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              );
            } else if (user.hasData) {
              return const LayoutScreen();
              //return const SellScreen();
            } else {
              return const AnimatedLoginScreen();
            }
          },
        ),

        // home: LayoutScreen(),
      ),
    );
  }
}
