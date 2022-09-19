import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:producteve/common/widgets/text_field_widget.dart';
import 'package:producteve/providers/user_details_provider.dart';
import 'package:producteve/resources/cloudfirestore_methods.dart';
import 'package:producteve/utils/color_themes.dart';
import 'package:producteve/utils/utils.dart';
import 'package:producteve/widgets/custom_main_button.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  final _nameController = TextEditingController();
  final _costController = TextEditingController();
  //
  bool isLoading = false;
  Uint8List? image;
  int selected = 1;
  //
  List<int> keysForDiscount = [0, 70, 60, 50];
  //
  uploadInitialProduct() async {
    String output = await CloudFirestoreClass().uoloadProductToDatabase(
      image: image,
      productName: _nameController.text,
      rawCost: _costController.text,
      discount: keysForDiscount[selected - 1],
      sellerName: Provider.of<UserDetailsProvider>(context, listen: false)
          .userDetails
          .name,
      sellerUid: FirebaseAuth.instance.currentUser!.uid,
    );
    if (output == 'success') {
      if (!mounted) return;
      showTopSnackBar(
        context,
        const CustomSnackBar.success(message: 'Posted Product'),
      );
      Navigator.pop(context);
    } else {
      if (!mounted) return;
      showTopSnackBar(
        context,
        CustomSnackBar.error(message: output),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _costController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = Utils().getScreenSize();
    return Scaffold(
      backgroundColor: Colors.white,
      body: !isLoading
          ? SingleChildScrollView(
              child: SizedBox(
                height: screenSize.height,
                width: screenSize.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Stack(
                          children: [
                            image == null
                                ? Image.network(
                                    "https://media.istockphoto.com/id/1321462048/photo/digital-transformation-concept-system-engineering-binary-code-programming.webp?s=612x612&w=is&k=20&c=-y3QGdyy9cROuoBI4dzZk1_N9jGC-5XwsK-Dsuiuyac=",
                                    height: screenSize.height / 10,
                                  )
                                : Image.memory(
                                    image!,
                                    height: screenSize.height / 10,
                                  ),
                            IconButton(
                              onPressed: () async {
                                Uint8List? temp = await Utils().pickImage();
                                if (temp != null) {
                                  setState(() {
                                    image = temp;
                                  });
                                }
                              },
                              icon: const Icon(Icons.file_upload),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 35,
                            vertical: 10,
                          ),
                          height: screenSize.height * 0.7,
                          width: screenSize.width * 0.9,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFieldWidget(
                                title: 'Name',
                                controller: _nameController,
                                obscureText: false,
                                hintText: 'Enter the name of the item',
                              ),
                              TextFieldWidget(
                                title: 'Cost',
                                controller: _costController,
                                obscureText: false,
                                hintText: 'Enter the cost of the item',
                              ),
                              const Text(
                                "Discount",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              ListTile(
                                title: const Text('None'),
                                leading: Radio(
                                  value: 1,
                                  groupValue: selected,
                                  onChanged: (int? i) {
                                    setState(() {
                                      selected = i!;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text("70%"),
                                leading: Radio(
                                  value: 2,
                                  groupValue: selected,
                                  onChanged: (int? i) {
                                    setState(() {
                                      selected = i!;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text("60%"),
                                leading: Radio(
                                  value: 3,
                                  groupValue: selected,
                                  onChanged: (int? i) {
                                    setState(() {
                                      selected = i!;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text("50%"),
                                leading: Radio(
                                  value: 4,
                                  groupValue: selected,
                                  onChanged: (int? i) {
                                    setState(() {
                                      selected = i!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        CustomMainButton(
                          color: yellowColor,
                          isLoading: isLoading,
                          onPressed: () {
                            uploadInitialProduct();
                            print('tapped');
                          },
                          child: const Text(
                            "Sell",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        CustomMainButton(
                            color: Colors.grey[300]!,
                            isLoading: false,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Back",
                              style: TextStyle(color: Colors.black),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            )
          : const Loader(),
    );
  }
}
