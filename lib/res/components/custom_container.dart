import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
class ReuseContainer extends StatelessWidget {
  final Widget child;
  final Callback onpress;
  ReuseContainer({super.key,
    required this.child,

    required this.onpress
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        height: 200,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          // gradient: LinearGradient(
          //   colors: [Color(0xFF64B5F6), Color(0xFF1976D2)],
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          // ),
          borderRadius:BorderRadius.circular(16.0),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.white.withOpacity(0.5),
          //     spreadRadius: 2,
          //     blurRadius: 5,
          //     offset: Offset(0, 3),
          //   ),
          // ],
        ),
        padding: EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}

