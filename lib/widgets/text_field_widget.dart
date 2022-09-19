import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final bool isObsecure;
  const TextFieldWidget({
    Key? key,
    required this.title,
    required this.hintText,
    required this.controller,
    required this.isObsecure,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ),
        SizedBox(
          height: 46,
          child: TextField(
            obscureText: widget.isObsecure,
            maxLines: 1,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.orange,
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
