import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../colors.dart';
class ReuseButton extends StatelessWidget {
  final String tittle;
  final Color color,textcolr;
  final VoidCallback onpress;
  final bool loading;
  ReuseButton({super.key,
    this.color=AppColors.elevatedButtonColour,required this.tittle,required this.onpress,
    this.textcolr=AppColors.lightBgColor,
    this.loading=false
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onpress,
      child: Container(
        height: 50.h,
        width: double.infinity,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(50)
        ),
        child: Center(
          child: loading ?Center(child: CircularProgressIndicator(color: Colors.white,)):Text(tittle,
            style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 16.sp,color: textcolr),),
        ),
      ),
    );();
  }
}


