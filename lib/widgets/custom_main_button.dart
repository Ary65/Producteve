import 'package:flutter/material.dart';
import 'package:producteve/utils/utils.dart';

class CustomMainButton extends StatelessWidget {
  final Color color;
  final bool isLoading;
  final VoidCallback onPressed;
  final Widget child;
  const CustomMainButton({
    Key? key,
    required this.color,
    required this.isLoading,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = Utils().getScreenSize();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: size.width * 0.7,
        height: 50,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
