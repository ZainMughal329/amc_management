



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../colors.dart';
class customTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final String? lableText;
  final FormFieldSetter? onFiledSubmittedValue;
  final Icon? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onPressSufix;
  final FormFieldValidator? onvalidator;
  Color? lableColor;
  final bool enable ,autoFocous;
  customTextField(
      {super.key,
        this.controller,
        this.lableText,
        this.hintText,
        this.focusNode,
        this.lableColor=AppColors.tittleColour,
        this.suffixIcon,
        this.prefixIcon,
        this.onFiledSubmittedValue,
        this.keyboardType,
        this.enable=true,
        this.onvalidator,
        this.autoFocous=false,
        this.onPressSufix});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          TextFormField(
            controller:  controller,
            focusNode: focusNode,
            // obscureText: obsecureText,
            onFieldSubmitted: onFiledSubmittedValue,
            validator: onvalidator,
            keyboardType: keyboardType,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(height: 0,fontSize: 15.sp),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: onPressSufix,
                icon: Icon(suffixIcon,color: Colors.grey,),
              ),
              hintText: hintText,
              prefixIcon: prefixIcon,
              labelText: lableText,
              labelStyle: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: lableColor
                ),
              ),
              enabled: enable,
              contentPadding: EdgeInsets.all(15),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),

              ),
            ),
          ),
        ],
      ),
    );
  }
}
