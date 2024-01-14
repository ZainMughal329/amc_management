import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../colors.dart';
import '../../../global.dart';
import '../../textWidget.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback onpress;
  final String lottie;

  SectionCard({
    required this.title,
    required this.onpress,
     this.icon,
     required this.lottie,
  });

  @override
  Widget build(BuildContext context) {
    mq =MediaQuery.sizeOf(context);
    return InkWell(
      onTap: onpress,
      child: Container(
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor,
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ],
          // gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   colors: [
          //     AppColors.gradientStart, // Adjust gradient start color
          //     AppColors.gradientEnd,   // Adjust gradient end color
          //   ],
          // ),
        ),
        child: Row(
          children: [
            Lottie.asset(lottie,width:100),
            // Icon(icon, size: 64.0, color: AppColors.homeViewcardIconColor),
            // SizedBox(height: 20.0),
            Spacer(),
        AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
                title,textStyle: GoogleFonts.poppins(
                fontSize: 15, color: AppColors.tittleColour
            ),
                speed: const Duration(milliseconds: 100)
            ),

          ],
          totalRepeatCount: 4,
          // repeatForever: 5,
        ),
            // Text(
            //   title,
            //   style: TextStyle(),
            // ),
            Spacer(flex: 2,),

          ],
        ),
      ),
    );
  }
}



// class cardWidget1 extends StatelessWidget {
//   final String title;
//   // final IconData icon;
//   final VoidCallback onpress;
//   cardWidget1({super.key,
//     required this.title,
//     required this.onpress,
//     // required this.icon,
//   });
//   @override
//   Widget build(BuildContext context) {
//     Animate.restartOnHotReload=true;
//     return InkWell(
//       onTap: onpress,
//       child: Card(
//         color: Colors.blue,
//         elevation: 0,
//         margin: EdgeInsets.only(bottom: mq.width*.02),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
//         child:Row(
//           children: [
//             Container(
//               // padding: homecard.padding,
//                 width:  mq.width*.35,
//                 child: Lottie.asset('assets/animations/recover password.json',width: mq.width*.01)),
//             Spacer(),
//             Expanded(
//               child: Text(
//                 title,style: TextStyle(
//                   fontSize:18,fontWeight: FontWeight.w500,letterSpacing: 1
//               ),),
//             ),
//             Spacer(),
//             Spacer(flex: 2,)
//           ],
//         ),
//       ).animate().fade(duration: 1000.ms),
//     );
//   }
// }
