import 'package:flutter/material.dart';
import '../colors.dart';
class ReuseButton extends StatelessWidget {
  final String tittle;
  final Color color,textcolr;
  final VoidCallback onpress;
  final bool loading;
  ReuseButton({super.key,
    this.color=AppColors.primaryTextTextColor,required this.tittle,required this.onpress,
    this.textcolr=AppColors.whiteColor,
    this.loading=false
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading?null:onpress,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(50)
        ),
        child: Center(
          child: loading ?Center(child: CircularProgressIndicator(color: Colors.white,)):Text(tittle,
            style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 16,color: textcolr),),
        ),
      ),
    );();
  }
}
