import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  final Color? color;
  final double? fontSize;
  final String? text;
  final FontWeight? fontWeight;


  const CommonText({Key? key,
  this.color,
  this.text,
  this.fontWeight,
  this.fontSize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text??"",style: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ),
    );
  }
}
