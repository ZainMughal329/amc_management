import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class detailTextFormField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final FormFieldSetter? onFiledSubmittedValue;
  final FormFieldValidator? onvalidator;
  final bool enable ,autoFocous;
  detailTextFormField(
      {super.key,
        this.controller,
        this.hintText,
        this.focusNode,
        this.onFiledSubmittedValue,
        this.keyboardType,
        this.enable=true,
        this.onvalidator,
        this.autoFocous=false,
      });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          TextField(
            controller:  controller,
            focusNode: focusNode,
            maxLines: 4,
            // onFieldSubmitted: onFiledSubmittedValue,
            // validator: onvalidator,
            keyboardType: keyboardType,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(height: 0,fontSize: 15.sp),
            decoration: InputDecoration(
              hintText: hintText,
              enabled: enable,
              contentPadding: EdgeInsets.all(15),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
