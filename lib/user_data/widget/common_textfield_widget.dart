import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  const CommonTextField({
    Key? key,
    required this.labelText,
     this.hintText,
     this.suffixIcon,
     this.onChanged,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          autofocus: true,
          onChanged: onChanged,
          controller: controller,
          decoration:
              InputDecoration(labelText: labelText, border: OutlineInputBorder(),
              hintText: hintText,
                suffixIcon: suffixIcon,
              ),
        ),
        SizedBox(height: 16,)
      ],
    );
  }
}
