import 'package:amc_management/res/components/textWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../colors.dart';
class ReuseField extends StatelessWidget {
  ReuseField({super.key,
    required this.myController,
    this.lableText='',
    this.focusNode,
    this.suffixIcon,
    this.prefixIcon,
    required this.onFiledSubmittedValue,
    required this.keyboardType,
    this.obsecureText=true,
    this.onPressSufix,
    this.lableColor=AppColors.tittleColour,
    this.enable=true,
    this.iconcolour =Colors.grey,
    required this.onvalidator,
    this.autoFocous=false
  });
  final TextEditingController myController;
  final FocusNode? focusNode;
   Color? iconcolour,lableColor;
  final  String lableText;
   final FormFieldSetter onFiledSubmittedValue;
  final Icon? prefixIcon;
  final IconData? suffixIcon;
  // final VoidCallback? onPressPre;
  final VoidCallback? onPressSufix;
  final FormFieldValidator onvalidator;
  final TextInputType keyboardType;
  // final String hint;
    bool obsecureText;
  final bool enable ,autoFocous;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          TextFormField(
            controller:  myController,
             focusNode: focusNode,
            obscureText: obsecureText,
             onFieldSubmitted: onFiledSubmittedValue,
            validator: onvalidator,
            keyboardType: keyboardType,
              // textAlign: TextAlign.center,
              style:
              Theme.of(context).textTheme.bodyText2!.copyWith(height: 0,fontSize: 15.sp),
            onTapOutside: (e) => FocusScope.of(context).unfocus(),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  if (onPressSufix != null) {
                    onPressSufix!();
                  }
                },
                icon: Icon(suffixIcon,color: iconcolour,),
              ),
              prefixIcon: prefixIcon,
              labelText: lableText,
              labelStyle: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: lableColor
                ),
              ),
              // contentPadding: EdgeInsets.only(left: 12, right: 20, top: 35, bottom: 15),
              contentPadding: EdgeInsets.all(15),
              // hintText: hint,
              enabled: enable,
              border: OutlineInputBorder(
                  // borderSide: BorderSide(color: AppColors.errorColor),
                  borderRadius: BorderRadius.circular(10)
              ),
               focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.cardTextColourS),
                  borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              // focusedErrorBorder: OutlineInputBorder(
              //     borderSide: BorderSide(color: AppColors.errorColor),
              //     borderRadius: BorderRadius.all(Radius.circular(8))
              // ),
              enabledBorder: OutlineInputBorder(

                // borderSide: BorderSide(color: AppColors.cardBgColour),

                  // borderSide: BorderSide(color: AppColors.warningColor),
                  borderRadius: BorderRadius.circular(10)
              ),
              // alignLabelWithHint: true
            ),
          ),
        ],
      ),
    );
  }
}
