import 'package:flutter/cupertino.dart';

import 'crt_scanlines_painter.dart';

class CRTScreen extends StatefulWidget {
  const CRTScreen({super.key, required this.builder});

  final Widget Function(BuildContext, Animation<double>) builder;

  @override
  State<CRTScreen> createState() => _CRTScreenState();
}

class _CRTScreenState extends State<CRTScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
      reverseDuration: const Duration(milliseconds: 500),
    );
    Animation<double> ca = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceIn,
      reverseCurve: Curves.bounceOut,
    );

    _animation = Tween<double>(
      begin: 3,
      end: 10,
    ).animate(ca)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _controller
      ..addListener(() => setState(() {}))
      ..forward(from: 0);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => IgnorePointer(
      ignoring: true,
      child: Stack(
        alignment: Alignment.center,
        children: [
          widget.builder(context, _animation),
          CustomPaint(
            willChange: true,
            painter: CrtScanlinesPainter(),
          )
        ].map((e) => Positioned.fill(child: e)).toList(),
      ));
}
