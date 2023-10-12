import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../colors.dart';
class ReuseField extends StatelessWidget {
  ReuseField({super.key,
    required this.myController,
    // required this.focusNode,
    required this.onFiledSubmittedValue,
    required this.keyboardType,
    required this.obsecureText,
    required this.hint,
    this.enable=true,
    required this.onvalidator,
    this.autoFocous=false
  });
  final TextEditingController myController;
  // final FocusNode focusNode;
   final FormFieldSetter onFiledSubmittedValue;
  final FormFieldValidator onvalidator;
  final TextInputType keyboardType;
  final String hint;
  final bool obsecureText;
  final bool enable ,autoFocous;
  // IconData? prefixIcon;
  // IconData? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          TextFormField(
            controller:  myController,
            // focusNode: focusNode,
            obscureText: obsecureText,
             onFieldSubmitted: onFiledSubmittedValue,
            validator: onvalidator,
            keyboardType: keyboardType,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(height: 0,fontSize: 15.sp),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15),
              hintText: hint,
              enabled: enable,
              // prefixIcon: null,
              // suffixIcon: null,
              hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(height:0,color: AppColors.lightTextColor.withOpacity(0.8)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.errorColor),
                  borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.lightTextColor),
                  borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.errorColor),
                  borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.warningColor),
                  borderRadius: BorderRadius.all(Radius.circular(8))
              ),
            ),
          ),
        ],
      ),
    );
  }
}
