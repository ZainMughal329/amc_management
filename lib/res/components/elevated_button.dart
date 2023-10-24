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
        backgroundColor: Colors.indigo
      ),
      onPressed:onpress,
      // loading?null:onpress ,
      child: loading==false?Text(tittle,style: TextStyle(color: Colors.white),):Center(child: CircularProgressIndicator())
    );
  }
}
