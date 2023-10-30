import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    // this.onPressPre,
    this.enable=true,
    required this.onvalidator,
    this.autoFocous=false
  });
  final TextEditingController myController;
  final FocusNode? focusNode;
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
              style: Theme.of(context).textTheme.bodyText2!.copyWith(height: 0,fontSize: 15.sp),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: onPressSufix,
                icon: Icon(suffixIcon,color: Colors.grey,),
              ),
              prefixIcon: prefixIcon,
              labelText: lableText,
              contentPadding: EdgeInsets.all(15),
              // hintText: hint,
              enabled: enable,
              // hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(height:0,color: AppColors.lightTextColor.withOpacity(0.8)),
              border: OutlineInputBorder(
                  // borderSide: BorderSide(color: AppColors.errorColor),
                  borderRadius: BorderRadius.circular(10)
              ),
              // focusedBorder: OutlineInputBorder(
              //     borderSide: BorderSide(color: AppColors.lightTextColor),
              //     borderRadius: BorderRadius.all(Radius.circular(8))
              // ),
              // focusedErrorBorder: OutlineInputBorder(
              //     borderSide: BorderSide(color: AppColors.errorColor),
              //     borderRadius: BorderRadius.all(Radius.circular(8))
              // ),
              enabledBorder: OutlineInputBorder(
                  // borderSide: BorderSide(color: AppColors.warningColor),
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
