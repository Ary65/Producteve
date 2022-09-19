// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:producteve/common/widgets/cost_widget.dart';
import 'package:producteve/common/widgets/rating_star_widget.dart';
import 'package:producteve/common/widgets/result_screen.dart';

import 'package:producteve/models/product_model.dart';
import 'package:producteve/models/review_model.dart';
import 'package:producteve/pages/home/widgets/user_details_bar.dart';
import 'package:producteve/pages/product/widgets/review_dialog.dart';
import 'package:producteve/pages/product/widgets/review_widget.dart';
import 'package:producteve/providers/user_details_provider.dart';
import 'package:producteve/resources/cloudfirestore_methods.dart';
import 'package:producteve/utils/color_themes.dart';
import 'package:producteve/utils/constants.dart';
import 'package:producteve/utils/utils.dart';
import 'package:producteve/widgets/custom_main_button.dart';
import 'package:producteve/widgets/custom_simple_rounded_button.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ProductScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductScreen({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Expanded spaceThingy = Expanded(child: Container());
  
  void navigateToResultScreen(String query) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(query: query),
        ));
  }

  Future placeOrder() async {
    await CloudFirestoreClass().addProductToOrders(
      model: widget.productModel,
      userDetails: Provider.of<UserDetailsProvider>(
        context,
        listen: false,
      ).userDetails,
    );
    if (!mounted) return;
    showTopSnackBar(
      context,
      const CustomSnackBar.success(message: 'Done'),
    );
  }

  Future addToCart() async {
    await CloudFirestoreClass()
        .addProductToCart(productModel: widget.productModel);
    if (!mounted) return;
    showTopSnackBar(
      context,
      const CustomSnackBar.success(message: 'Added to cart'),
    );
  }

  void reviewDialog() {
    showDialog(
      context: context,
      builder: (context) => ReviewDialog(
        productUid: widget.productModel.uid,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = Utils().getScreenSize();
    return SafeArea(
      child: Scaffold(
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
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenSize.height -
                          (kAppBarHeight + (kAppBarHeight / 2)),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: kAppBarHeight / 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        widget.productModel.sellerName,
                                        style: const TextStyle(
                                            color: activeCyanColor,
                                            fontSize: 16),
                                      ),
                                    ),
                                    Text(widget.productModel.productName),
                                  ],
                                ),
                                //* RattingBar
                                RatingStarWidget(
                                    rating: widget.productModel.rating),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
                              height: screenSize.height / 3,
                              constraints: BoxConstraints(
                                  maxHeight: screenSize.height / 3),
                              child: Image.network(widget.productModel.url),
                            ),
                          ),
                          spaceThingy,
                          CostWidget(
                            color: Colors.black,
                            cost: widget.productModel.cost,
                          ),
                          spaceThingy,
                          CustomMainButton(
                            color: Colors.orange,
                            isLoading: false,
                            onPressed: placeOrder,
                            child: const Text(
                              "Buy Now",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          spaceThingy,
                          CustomMainButton(
                            color: Colors.yellow,
                            isLoading: false,
                            onPressed: addToCart,
                            child: const Text(
                              "Add to cart",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          spaceThingy,
                          CustomSimpleRoundedButton(
                            onPressed: reviewDialog,
                            text: "Add a review for this product",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('products')
                            .doc(widget.productModel.uid)
                            .collection('reviewa')
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Loader();
                          } else {
                            return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                ReviewModel model = ReviewModel.fromMap(
                                    map: snapshot.data!.docs[index].data());
                                return ReviewWidget(review: model);
                              },
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            const UserDetailsBar(
              offset: 0,
            )
          ],
        ),
      ),
    );
  }
}
