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
    this.height,
  });

  final String _text;
  final double blurRadius;
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return GlowText(
      _text,
      glowColor:
          CupertinoColors.white.withRed(180).withGreen(230).withOpacity(.7),
      offset: const Offset(0, 0),
      blurRadius: blurRadius,
      textAlign: TextAlign.center,
      style: TextStyle(
        color:
            CupertinoColors.white.withRed(200).withGreen(230).withOpacity(.85),
        height: height,
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontFamily: fontFamily,
      ),
    );
  }
}
