
import 'package:flutter/material.dart';
import 'package:amc_management/res/colors.dart';
class BigAppText extends StatelessWidget {
  final String text;
  final int size;
  const BigAppText({Key? key, required this.text, required this.size})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: size.toDouble(),
          color: AppColors.lightGrayColor),
    );
  }
}
class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;
  CircleTabIndicator({required this.color, required this.radius});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final double radius;
  late Color color;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint..isAntiAlias = true;
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}

// class BigAppText extends StatelessWidget {
//    final String text;
//    final int size;
//    BigAppText({super.key,
//    required this.text,
//      required this.size
//    });
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       style: TextStyle(
//         fontWeight: FontWeight.bold,
//         fontSize: size.toDouble(),
//         color: AppColors.lightGrayColor
//       ),
//     );
//   }
// }
//
// class CircleTabIndicator extends Decoration{
//
//   final Color color;
//   double raduis;
//
//   CircleTabIndicator({
//    required this.color,required this.raduis
// });
//
//   @override
//   BoxPainter createBoxPainter([VoidCallback? onChanged]) {
//     return _CirclePainter(
//       color:color,
//       raduis:raduis
//     );
//   }}
//
// class _CirclePainter extends BoxPainter{
//   final double radius;
//   late Color color;
//   _CirclePainter({
//     required this.color,
//     required
// });
// }
//
