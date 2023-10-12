
import 'package:flutter/material.dart';

import '../colors.dart';

class BigAppText extends StatelessWidget {
  final String text;
  final int size;
  const BigAppText({Key? key, required this.text, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: size.toDouble(),
          color: AppColors.lightActiveIconColor),
    );
  }
}