import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../colors.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onpress;

  SectionCard({
    required this.title,
    required this.onpress,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor,
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.gradientStart, // Adjust gradient start color
              AppColors.gradientEnd,   // Adjust gradient end color
            ],
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 64.0, color: AppColors.admincardiconColor),
            SizedBox(height: 16.0),
            Text(
              title,
              style: TextStyle(fontSize: 24.0, color: AppColors.admincardtextColor),
            ),
          ],
        ),
      ),
    );
  }
}