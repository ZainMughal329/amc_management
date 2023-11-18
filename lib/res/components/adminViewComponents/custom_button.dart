import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../colors.dart';
class ReuseButton extends StatelessWidget {
  final String tittle;
  final Color color,textcolr;
  final VoidCallback onpress;
  final IconData? icon;
  final bool loading;
  ReuseButton({super.key,
    this.color=AppColors.reuseAbleButtonColourS,required this.tittle,required this.onpress,
    this.textcolr=AppColors.tittleColour,
     this.icon,
    this.loading=false

  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onpress,
      child: Container(
        height: 35.h,
        width: 130.w,
        decoration: BoxDecoration(
            color: color.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12)
        ),
        child: Center(
          child: loading ?Center(child: CircularProgressIndicator(color: Colors.white,)):
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,size: 16,color: AppColors.iCONColour,),
              SizedBox(width: 2.w),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue), // Adjust the color as needed
                  borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    tittle,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
              ),
              // Text(tittle,
              //   style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 14.sp,color: textcolr)
              //   ,),
            ],
          ),
        ),
      ),
    );();
  }
}


