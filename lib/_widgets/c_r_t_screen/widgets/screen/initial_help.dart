import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../c_r_t_glow_text.dart';

class InitialHelp extends StatefulWidget {
  const InitialHelp({super.key, required this.animation});
  final Animation<double> animation;

  @override
  State<InitialHelp> createState() => _InitialHelpState();
}

class _InitialHelpState extends State<InitialHelp>
    with SingleTickerProviderStateMixin {
  bool _ticker = false;

  late Timer ticker;

  @override
  void initState() {
    super.initState();
    ticker = Timer.periodic(const Duration(milliseconds: 2000), (_) {
      setState(() => _ticker = !_ticker);
    });
  }

  @override
  void dispose() {
    ticker.cancel();
    super.dispose();
  }

  Widget _glowTextArrow(bool direction) => Transform.scale(
        scaleY: .3,
        scaleX: 1.2,
        child: CRTGlowText(
          direction ? 'ᐱ' : 'ᐯ',
          blurRadius: widget.animation.value.abs(),
          fontWeight: FontWeight.w400,
          fontSize: 60,
          height: .2,
          fontFamily: 'Arial',
        ),
      );

  Widget get _glowTextArrowDown => _glowTextArrow(false);

  @override
  Widget build(BuildContext context) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 450),
        reverseDuration: const Duration(milliseconds: 320),
        switchInCurve: Curves.bounceIn,
        switchOutCurve: Curves.bounceOut,
        child: _ticker
            ? Column(
                key: ValueKey<bool>(_ticker),
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CRTGlowText(
                    'Swipe down to type question',
                    height: 1.1,
                    blurRadius: widget.animation.value.abs(),
                  ),
                  const SizedBox(height: 18),
                  _glowTextArrowDown,
                  _glowTextArrowDown,
                  _glowTextArrowDown,
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  CRTGlowText(
                    'Hold to ask\nvia voice',
                    height: 1.1,
                    blurRadius: widget.animation.value.abs(),
                  ),
                  const SizedBox(height: 48),
                  CRTGlowText(
                    '⦾',
                    height: .2,
                    fontSize: 90,
                    fontWeight: FontWeight.w100,
                    blurRadius: widget.animation.value.abs(),
                  ),
                ],
              ),
      );
}
