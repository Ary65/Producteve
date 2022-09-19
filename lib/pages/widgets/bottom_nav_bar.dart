// import 'package:flutter/material.dart';
// import 'package:producteve/utils/utils.dart';

// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({Key? key}) : super(key: key);

//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   var currentIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Padding(
//       padding: const EdgeInsets.all(8),
//       child: Container(
//         // color: const Color(0xffF15F60),
//         decoration: BoxDecoration(
//           gradient: gradientGlobal,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         height: size.width * .155,
//         // color: Colors.deepPurpleAccent,
//         child: ListView.builder(
//           itemCount: 4,
//           scrollDirection: Axis.horizontal,
//           padding: EdgeInsets.symmetric(horizontal: size.width * .024),
//           itemBuilder: (context, index) => InkWell(
//             onTap: () {
//               setState(() {
//                 currentIndex = index;
//               });
//             },
//             splashColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox(height: size.width * .014),
//                 Icon(
//                   listOfIcons[index],
//                   size: size.width * .076,
//                   color: Colors.white,
//                 ),
//                 AnimatedContainer(
//                   duration: const Duration(milliseconds: 1500),
//                   curve: Curves.fastLinearToSlowEaseIn,
//                   margin: EdgeInsets.only(
//                     top: index == currentIndex ? 0 : size.width * .029,
//                     right: size.width * .0422,
//                     left: size.width * .0422,
//                   ),
//                   width: size.width * .153,
//                   height: index == currentIndex ? size.width * .014 : 0,
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.vertical(
//                       top: Radius.circular(20),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   List<IconData> listOfIcons = [
//     Icons.home_rounded,
//     Icons.favorite_rounded,
//     Icons.settings_rounded,
//     Icons.person_rounded,
//   ];
// }
