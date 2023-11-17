import 'package:amc_management/res/colors.dart';
import 'package:flutter/material.dart';
class elevatedButton extends StatelessWidget {
  final String tittle;
  final VoidCallback onpress;
  final bool loading;
  elevatedButton({super.key,
   required this.tittle,required this.onpress,
    this.loading=false
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: AppColors.elevatedButtonColour
      ),
      onPressed:onpress,
      child: loading?Center(child: CircularProgressIndicator(color: AppColors.circularProgressIndicatorColour,)):Text(tittle,style: TextStyle(color:AppColors.textColour),)
    );
  }
}
