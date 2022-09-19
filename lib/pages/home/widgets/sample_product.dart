import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:producteve/utils/utils.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SampleProduct extends StatefulWidget {
  SampleProduct({Key? key}) : super(key: key);

  @override
  State<SampleProduct> createState() => _SampleProductState();
}

class _SampleProductState extends State<SampleProduct> {
  var productData = {};
  bool isLoading = false;
  String uid = Utils().getUid();
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
      var productSnap = await FirebaseFirestore.instance
          .collection('products')
          .doc('100009')
          .get();
      productData = productSnap.data()!;
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
    final size = Utils().getScreenSize();
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.3,
          width: size.width * 0.8,
          child: Image.network(productData['url']),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          productData['productName'] ?? '',
          style: TextStyle(fontSize: 30),
        )
      ],
    );
  }
}
