import 'package:flutter/cupertino.dart';
import 'package:flutter_glow/flutter_glow.dart';

class CRTGlowText extends StatelessWidget {
  const CRTGlowText(
    this._text, {
    super.key,
    this.blurRadius = 0,
    this.fontSize = 35,
    this.fontWeight = FontWeight.w600,
    this.fontFamily = 'TextMeOne',
  });

  final String _text;
  final double blurRadius;
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return GlowText(
      _text,
      glowColor:
          CupertinoColors.white.withRed(180).withGreen(230).withOpacity(.7),
      offset: const Offset(0, 0),
      blurRadius: blurRadius,
      style: TextStyle(
        color:
            CupertinoColors.white.withRed(200).withGreen(230).withOpacity(.85),
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontFamily: fontFamily,
      ),
    );
  }
}
