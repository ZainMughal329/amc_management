


import 'package:flutter/cupertino.dart';

class ReuseableUtils{
  static void fieldfocous(BuildContext context,FocusNode currentfocous,FocusNode nextfocous){
    currentfocous.unfocus();
    FocusScope.of(context).requestFocus(nextfocous);
  }
}