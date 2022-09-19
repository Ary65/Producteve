import 'package:flutter/material.dart';
import 'package:producteve/utils/color_themes.dart';

import '../../utils/constants.dart';

class BannerAd extends StatefulWidget {
  const BannerAd({Key? key}) : super(key: key);

  @override
  State<BannerAd> createState() => _BannerAdState();
}

class _BannerAdState extends State<BannerAd> {
  int currentAd = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double smallAdDimension = size.width / 5;
    return Column(
      children: [
        Stack(
          children: [
            GestureDetector(
              onHorizontalDragEnd: (details) {
                if (currentAd == (largeAds.length - 1)) {
                  currentAd = -1;
                }
                setState(() {
                  currentAd++;
                });
              },
              child: SizedBox(
                width: double.infinity,
                child: Image.network(
                  largeAds[currentAd],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: size.width,
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      backgroundColor,
                      backgroundColor.withOpacity(0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          color: backgroundColor,
          height: smallAdDimension,
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              getSmallAdWidget(
                index: 0,
                side: smallAdDimension,
              ),
              getSmallAdWidget(
                index: 1,
                side: smallAdDimension,
              ),
              getSmallAdWidget(
                index: 2,
                side: smallAdDimension,
              ),
              getSmallAdWidget(
                index: 3,
                side: smallAdDimension,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getSmallAdWidget({required int index, required double side}) {
    return Container(
      height: side,
      width: side,
      decoration: ShapeDecoration(
        color: Colors.white,
        shadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: FittedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                smallAds[index],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  adItemNames[index],
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
