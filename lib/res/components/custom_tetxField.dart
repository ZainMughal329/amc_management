import 'package:flutter/material.dart';
import '../colors.dart';
class ReuseField extends StatelessWidget {
  ReuseField({super.key,
    required this.myController,
    required this.focusNode,
    required this.onFiledSubmittedValue,
    required this.keyboardType,
    required this.obsecureText,
    required this.hint,
    this.enable=true,
    required this.onvalidator,
    this.autoFocous=false
  });
  final TextEditingController myController;
  final FocusNode focusNode;
   final FormFieldSetter onFiledSubmittedValue;
  final FormFieldValidator onvalidator;
  final TextInputType keyboardType;
  final String hint;
  final bool obsecureText;
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
              style: Theme.of(context).textTheme.bodyText2!.copyWith(height: 0,fontSize: 10),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15),
              hintText: hint,
              enabled: enable,
              hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(height:0,color: AppColors.primaryTextTextColor.withOpacity(0.8)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.textFieldDefaultFocus),
                  borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.secondaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.alertColor),
                  borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.textFieldDefaultBorderColor),
                  borderRadius: BorderRadius.all(Radius.circular(8))
              ),
            ),
          ),
        ],
      ),
    );
  }
}
