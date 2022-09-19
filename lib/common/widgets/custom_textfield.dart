import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onTap;
  final Icon icon;
  const CustomTextField({
    Key? key,
    required this.controller,
    this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      //  margin: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
      style: NeumorphicStyle(
        boxShape: const NeumorphicBoxShape.stadium(),
        depth: NeumorphicTheme.embossDepth(context),
      ),
      child: SizedBox(
        height: 50,
        child: TextField(
          onSubmitted: onTap,
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: icon,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(
                color: Color.fromRGBO(21, 181, 114, 1),
                width: 2,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(239, 239, 241, 1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
