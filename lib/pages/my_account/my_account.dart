import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:producteve/pages/auth/animated/animated_login_screen.dart';
import 'package:producteve/utils/utils.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  var userData = {};
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      userData = userSnap.data()!;
      setState(() {});
    } catch (e) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(message: e.toString()),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: gradientGlobal,
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Loader()
          : Column(
              children: [
                // Container(
                //   padding: const EdgeInsets.only(top: 30),
                //   height: 200,
                //   width: double.infinity,
                //   child: const CircleAvatar(
                //     backgroundImage: NetworkImage(
                //       'https://images.unsplash.com/photo-1659862925038-08a86ddfeb1e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMjB8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
                //     ),
                //     radius: 64,
                //   ),
                // ),
                //
                Center(
                  child: Lottie.asset('assets/35726-my-profile-icon.json'),
                ),
                const SizedBox(height: 30),
                Column(
                  children: [
                    UserInfo(
                      text: userData['name'] ?? '',
                    ),
                    UserInfo(
                      text: userData['address'] ?? '',
                    ),
                    InkWell(
                      onTap: () {},
                      child: UserInfo(
                        text:
                            FirebaseAuth.instance.currentUser!.email.toString(),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AnimatedLoginScreen(),
                            ),);
                      },
                      child: const UserInfo(text: 'Log out'),
                    ),
                  ],
                )
              ],
            ),
    );
  }
}

class UserInfo extends StatelessWidget {
  final String text;
  const UserInfo({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white54,
        ),
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(
            text,
          ),
        ),
      ),
    );
  }
}
