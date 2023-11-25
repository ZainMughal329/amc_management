import 'package:amc_management/res/colors.dart';
import 'package:flutter/material.dart';


class box_button extends StatelessWidget {
  const box_button({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: 250, // Width of the background button
          height: 60, // Height of the background button
          decoration: BoxDecoration(
            color: Colors.black, // Background color of the bottom button
            borderRadius: BorderRadius.circular(30), // Border radius of the bottom button
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.black, // Background color of the top button
            onPrimary: AppColors.buttonColour, // Text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Border radius of the top button
            ),
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16), // Padding inside the button
            elevation: 0, // Removes shadow to make it flat on the bottom button
          ),
          onPressed: () {
            // Your action goes here
          },
          child: Text(
            'Sr. Flutter Developer',
            style: TextStyle(
              fontSize: 16, // Font size
              fontWeight: FontWeight.bold, // Font weight
            ),
          ),
        ),
      ],
    );
  }
}
