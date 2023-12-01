import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class detailTextFormField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final String? lableText;
  final Icon? prefixIcon;
  final FormFieldSetter? onFiledSubmittedValue;
  final FormFieldValidator? onvalidator;
  final bool enable ,autoFocous;
  detailTextFormField(
      {super.key,
        this.controller,
        this.hintText,
        this.lableText,
        this.focusNode,
        this.prefixIcon,
        this.onFiledSubmittedValue,
        this.keyboardType,
        this.enable=true,
        this.onvalidator,
        this.autoFocous=false,
      });
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller:  controller,
      focusNode: focusNode,
      maxLines: 3,
      keyboardType: keyboardType,
      style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 15.sp),
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        hintText: hintText,
        labelText:lableText,
        prefixIcon: prefixIcon,
        enabled: enable,
        contentPadding: EdgeInsets.all(15),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
        ),
      ),
    );
  }
}
