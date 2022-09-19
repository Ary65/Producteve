import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:producteve/common/widgets/result_screen.dart';
import 'package:producteve/models/product_model.dart';
import 'package:producteve/pages/cart/widget/cart_item_widget.dart';
import 'package:producteve/pages/home/widgets/user_details_bar.dart';
import 'package:producteve/providers/user_details_provider.dart';
import 'package:producteve/resources/cloudfirestore_methods.dart';
import 'package:producteve/utils/color_themes.dart';
import 'package:producteve/utils/constants.dart';
import 'package:producteve/utils/utils.dart';
import 'package:producteve/widgets/custom_main_button.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  //
  Future buyAllItemsOfCart() async {
    await CloudFirestoreClass().buyAllItemsInCart(
        userDetails: Provider.of<UserDetailsProvider>(context, listen: false)
            .userDetails);
    if (!mounted) return;
    showTopSnackBar(
      context,
      const CustomSnackBar.success(message: 'Done'),
    );
  }

  void navigateToResultScreen(String query) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(query: query),
        ));
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  alignment: Alignment.topLeft,
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToResultScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide:
                              BorderSide(color: Colors.black38, width: 1),
                        ),
                        hintText: 'Search Amazon.in',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic, color: Colors.black, size: 25),
              )
            ],
          ),
        ),
      ),
      body: Center(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: kAppBarHeight / 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('cart')
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CustomMainButton(
                          color: yellowColor,
                          isLoading: true,
                          onPressed: () {},
                          child: const Text('Loading'),
                        );
                      } else {
                        // return MyElevatedButton(
                        //   onPressed: () {},
                        //   child: const Text('Proceed to deliver'),
                        //   borderRadius: BorderRadius.circular(7),
                        // );

                        return CustomMainButton(
                          color: yellowColor,
                          isLoading: false,
                          onPressed: buyAllItemsOfCart,
                          child: Text(
                            'proceed to buy(${snapshot.data!.docs.length}) items',
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      }
                    },
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('cart')
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Loader();
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            ProductModel model = ProductModel.getModelFromJson(
                                json: snapshot.data!.docs[index].data());
                            return CartItemWidget(
                              product: model,
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            const UserDetailsBar(offset: 0)
          ],
        ),
      ),
    );
  }
}
