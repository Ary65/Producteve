// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:producteve/utils/constants.dart';

import 'package:producteve/utils/utils.dart';

class SearchBarWidget extends StatelessWidget with PreferredSizeWidget {
  final bool isReadOnly;
  final bool hasBackButton;
  SearchBarWidget({
    Key? key,
    required this.isReadOnly,
    required this.hasBackButton,
  })  : preferredSize = const Size.fromHeight(kAppBarHeight),
        super(key: key);
  @override
  final Size preferredSize;
  OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(7),
    borderSide: const BorderSide(
      color: Colors.grey,
      width: 1,
    ),
  );

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Container(
      height: kAppBarHeight,
      decoration: const BoxDecoration(
        gradient: gradientGlobal,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          hasBackButton
              ? IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back))
              : Container(),
          SizedBox(
            width: screenSize.width * 0.7,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                readOnly: isReadOnly,
                decoration: InputDecoration(
                  hintText: "Search for products",
                  fillColor: Colors.white,
                  filled: true,
                  border: border,
                  focusedBorder: border,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.mic_none_outlined),
          )
        ],
      ),
    );

    // return PreferredSize(
    //   preferredSize: const Size.fromHeight(60),
    //   child: AppBar(
    //     elevation: 0,
    //     flexibleSpace: Container(
    //       decoration: const BoxDecoration(
    //         gradient: gradientGlobal,
    //       ),
    //     ),
    //     title: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Expanded(
    //           child: Container(
    //             height: 42,
    //             margin: const EdgeInsets.only(left: 15),
    //             alignment: Alignment.topLeft,
    //             child: Material(
    //               borderRadius: BorderRadius.circular(7),
    //               elevation: 1,
    //               child: TextFormField(
    //                 decoration: InputDecoration(
    //                   prefixIcon: InkWell(
    //                     onTap: () {},
    //                     child: const Padding(
    //                       padding: EdgeInsets.only(
    //                         left: 6,
    //                       ),
    //                       child: Icon(
    //                         Icons.search,
    //                         color: Colors.black,
    //                         size: 23,
    //                       ),
    //                     ),
    //                   ),
    //                   filled: true,
    //                   fillColor: Colors.white,
    //                   contentPadding: const EdgeInsets.only(top: 10),
    //                   border: const OutlineInputBorder(
    //                     borderRadius: BorderRadius.all(
    //                       Radius.circular(7),
    //                     ),
    //                     borderSide: BorderSide.none,
    //                   ),
    //                   enabledBorder: const OutlineInputBorder(
    //                     borderRadius: BorderRadius.all(
    //                       Radius.circular(7),
    //                     ),
    //                     borderSide: BorderSide(color: Colors.black38, width: 1),
    //                   ),
    //                   hintText: 'Search Amazon.in',
    //                   hintStyle: const TextStyle(
    //                     fontWeight: FontWeight.w500,
    //                     fontSize: 17,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //         Container(
    //           color: Colors.transparent,
    //           height: 42,
    //           margin: const EdgeInsets.symmetric(horizontal: 10),
    //           child: const Icon(Icons.mic, color: Colors.black, size: 25),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
