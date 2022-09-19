// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:producteve/models/product_model.dart';
import 'package:producteve/pages/product/product_screen.dart';
import 'package:producteve/utils/utils.dart';

class ResultsWidget extends StatelessWidget {
  final ProductModel product;
  const ResultsWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductScreen(productModel: product),
            ));
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: screenSize.width / 3,
                child: Image.network(product.url),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  product.productName,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
