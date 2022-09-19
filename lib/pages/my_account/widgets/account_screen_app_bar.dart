import 'package:flutter/material.dart';
import 'package:producteve/utils/constants.dart';
import 'package:producteve/utils/utils.dart';

class AccountScreenAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  AccountScreenAppBar({Key? key})
      : preferredSize = const Size.fromHeight(kAppBarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = Utils().getScreenSize();
    return Container(
      height: 100,
      width: screenSize.width,
      decoration: const BoxDecoration(gradient: gradientGlobal),
      child: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Image.network(
                amazonLogoUrl,
                height: kAppBarHeight * 0.7,
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_outlined,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search_outlined,
                    color: Colors.black,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
