import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:producteve/models/order_request_model.dart';
import 'package:producteve/models/product_model.dart';
import 'package:producteve/models/user_details_model.dart';
import 'package:producteve/pages/my_account/my_account.dart';
import 'package:producteve/pages/my_account/widgets/account_screen_app_bar.dart';
import 'package:producteve/pages/my_account/widgets/introduction.dart';
import 'package:producteve/pages/my_account/widgets/sell_screen.dart';
import 'package:producteve/pages/widgets/product_showcase.dart';
import 'package:producteve/pages/widgets/simple_product.dart';
import 'package:producteve/providers/user_details_provider.dart';
import 'package:producteve/utils/color_themes.dart';
import 'package:producteve/utils/constants.dart';
import 'package:producteve/utils/utils.dart';
import 'package:producteve/widgets/custom_main_button.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AccountScreenAppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Column(
            children: [
              const IntroductionWidgetAccountScreen(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomMainButton(
                  color: Colors.orange,
                  isLoading: false,
                  onPressed: () {},
                  child: const Text(
                    'Sign Out',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomMainButton(
                  color: yellowColor,
                  isLoading: false,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SellScreen()));
                  },
                  child: const Text(
                    'Sell',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('orders')
                    .get(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Loader();
                  } else {
                    List<Widget> children = [];
                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      ProductModel model = ProductModel.getModelFromJson(
                        json: snapshot.data!.docs[i].data(),
                      );
                      children.add(
                        SimpleProduct(productModel: model),
                      );
                    }
                    return ProductShowcase(
                        title: 'Your Orders', children: children);
                  }
                },
              ),
              const Padding(
                padding: EdgeInsets.all(8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Order Requests',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('orderRequest')
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
                          OrderRequestModel model = OrderRequestModel.fromMap(
                              map: snapshot.data!.docs[index].data());
                          return ListTile(
                            title: Text(
                              'Order: ${model.orderName}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('Address: ${model.buyersAddress}'),
                            trailing: IconButton(
                              onPressed: () async {
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(
                                      FirebaseAuth.instance.currentUser!.uid,
                                    )
                                    .collection('orderRequest')
                                    .doc(snapshot.data!.docs[index].id)
                                    .delete();
                              },
                              icon: const Icon(Icons.check),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IntroductionWidgetAccountScreen extends StatelessWidget {
  const IntroductionWidgetAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserDetailsModel userDetailsModel =
        Provider.of<UserDetailsProvider>(context).userDetails;
    return Container(
      height: kAppBarHeight / 2,
      decoration: const BoxDecoration(
        gradient: gradientGlobal,
      ),
      child: Container(
        height: kAppBarHeight / 2,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white.withOpacity(0.00000000001),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Hello, ",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 26,
                      ),
                    ),
                    TextSpan(
                      text: userDetailsModel.name,
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MyAccount(),
                  ));
                },
                child: const CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://m.media-amazon.com/images/I/116KbsvwCRL._SX90_SY90_.png",
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
