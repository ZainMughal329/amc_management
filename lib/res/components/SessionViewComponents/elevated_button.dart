import 'package:amc_management/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class elevatedButton extends StatelessWidget {
  final String tittle;
  final Color bgColor,textColor;
  final VoidCallback onpress;
  final bool loading;

  elevatedButton({super.key,
    this.textColor=AppColors.tittleColour,
    this.bgColor = AppColors.buttonColour,
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
        backgroundColor: bgColor
      ),
      onPressed:onpress,
      child: loading?Center(child: CircularProgressIndicator(color: AppColors.circularProgressIndicatorColour,)):Text(tittle,
        style:GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: 16,
              color:textColor
          )
        )
      )
    );
  }
}
