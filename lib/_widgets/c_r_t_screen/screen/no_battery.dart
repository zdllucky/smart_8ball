import 'package:flutter/cupertino.dart';

import 'c_r_t_glow_text.dart';

class NoBattery extends StatelessWidget {
  const NoBattery({super.key, required this.animation});
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CRTGlowText(
          '▒░░ı',
          blurRadius: animation.value.abs(),
          fontWeight: FontWeight.w400,
          fontSize: 60,
          fontFamily: 'Arial',
        ),
        const SizedBox(height: 16),
        CRTGlowText(
          'No tries left',
          blurRadius: animation.value.abs(),
        ),
      ],
    );
  }
}
