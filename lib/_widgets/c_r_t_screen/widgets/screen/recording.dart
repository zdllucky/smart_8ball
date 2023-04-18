import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:smart_8ball/_support/asset/__.dart';

import '../c_r_t_glow_text.dart';

class Recording extends StatefulWidget {
  const Recording({super.key, required this.animation});
  final Animation<double> animation;

  @override
  State<Recording> createState() => _RecordingState();
}

class _RecordingState extends State<Recording>
    with SingleTickerProviderStateMixin {
  int _ticker = 0;

  late Timer ticker;

  @override
  void initState() {
    super.initState();
    ticker = Timer.periodic(const Duration(milliseconds: 500), (_) {
      setState(() => _ticker = (_ticker + 1) % 4);
    });
  }

  @override
  void dispose() {
    ticker.cancel();
    super.dispose();
  }

  Widget _arrow(double fontSize, FontWeight fontWeight, bool visible) =>
      AnimatedOpacity(
        opacity: visible ? 1 : 0,
        key: ValueKey<int>(fontSize.toInt()),
        duration: const Duration(milliseconds: 300),
        child: CRTGlowText(
          ')',
          height: .8,
          fontSize: fontSize,
          fontWeight: FontWeight.w100,
          fontFamily: AppFont.nightClub70s,
          blurRadius: widget.animation.value.abs(),
        ),
      );

  @override
  Widget build(BuildContext context) => Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                _arrow(60, FontWeight.w900, _ticker >= 1),
                _arrow(90, FontWeight.w900, _ticker >= 2),
                _arrow(120, FontWeight.w400, _ticker >= 3),
              ],
            ),
            const SizedBox(height: 16),
            CRTGlowText(
              'Listening...',
              height: 1.1,
              blurRadius: widget.animation.value.abs(),
            ),
          ]);
}
