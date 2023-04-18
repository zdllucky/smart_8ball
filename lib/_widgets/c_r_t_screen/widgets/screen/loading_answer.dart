import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smart_8ball/_support/asset/font/app_font.dart';

import '../c_r_t_glow_text.dart';

class LoadingAnswer extends StatefulWidget {
  const LoadingAnswer({super.key, required this.animation});
  final Animation<double> animation;

  @override
  State<LoadingAnswer> createState() => _LoadingAnswerState();
}

class _LoadingAnswerState extends State<LoadingAnswer> {
  int _ticker = 0;

  late Timer ticker;

  @override
  void initState() {
    super.initState();
    ticker = Timer.periodic(const Duration(milliseconds: 300), (_) {
      setState(() => _ticker = (_ticker + 1) % 6);
    });
  }

  @override
  void dispose() {
    ticker.cancel();
    super.dispose();
  }

  String _symbolAtIndex(int index) => '⠋⠙⠸⠴⠦⠇'[index];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 48),
        Transform.rotate(
          angle: pi / 2,
          origin: const Offset(-5, -25),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            reverseDuration: const Duration(milliseconds: 1000),
            switchInCurve: Curves.linear,
            switchOutCurve: Curves.linear,
            child: CRTGlowText(
              key: ValueKey<int>(_ticker),
              _symbolAtIndex(_ticker),
              fontSize: 60,
              fontFamily: AppFont.membra,
              fontWeight: FontWeight.w100,
              height: .1,
              blurRadius: widget.animation.value.abs(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        CRTGlowText(
          'Thinking...',
          blurRadius: widget.animation.value.abs(),
        ),
      ],
    );
  }
}
