import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
class ReuseContainer extends StatelessWidget {
  final String image;
  final String title;
  final Color color;
  final Callback? onpress;

  ReuseContainer({super.key,
    required this.image,
    required this.title,
    required this.color,
     this.onpress
  });
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onpress,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withOpacity(0.7),
            width: 2,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: _screenWidth * 0.3,
                width: _screenWidth * 0.3,
                decoration: BoxDecoration(
                  image:
                  DecorationImage(image: NetworkImage(image), fit: BoxFit.fill),
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}

