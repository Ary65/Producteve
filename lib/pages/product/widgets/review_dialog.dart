// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:producteve/models/review_model.dart'; 
import 'package:producteve/providers/user_details_provider.dart';
import 'package:producteve/resources/cloudfirestore_methods.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ReviewDialog extends StatelessWidget {
  final String productUid;
  const ReviewDialog({
    Key? key,
    required this.productUid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingDialog(
      title: const Text(
        'Type a review for this product!',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      submitButtonText: 'Send',
      commentHint: 'Type here',
      onSubmitted: (RatingDialogResponse res) async {
        CloudFirestoreClass().uploadReviewToDatabase(
          productUid: productUid,
          model: ReviewModel(
            senderName: Provider.of<UserDetailsProvider>(
              context,
              listen: false,
            ).userDetails.name,
            description: res.comment,
            rating: res.rating.toInt(),
          ),
        );
      },
    );
  }
}
