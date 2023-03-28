import 'package:flutter/cupertino.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemedCSNavigationBar extends StatelessWidget {
  const ThemedCSNavigationBar(
      {super.key,
      this.previousPageTitle = 'Back',
      required this.middleText,
      this.largeTitleText,
      this.automaticallyImplyLeading = true,
      this.trailing,
      this.leading});
  final String previousPageTitle;
  final String middleText;
  final String? largeTitleText;
  final bool automaticallyImplyLeading;
  final Widget? trailing;
  final Widget? leading;

  @override
  Widget build(BuildContext context) => CupertinoSliverNavigationBar(
        key: super.key,
        automaticallyImplyLeading: automaticallyImplyLeading && leading == null,
        leading: leading,
        trailing: trailing,
        previousPageTitle: previousPageTitle,
        stretch: true,
        backgroundColor: const Color(0x00000000),
        automaticallyImplyTitle: largeTitleText == null,
        alwaysShowMiddle: largeTitleText != null,
        middle: Text(
          middleText,
          style: const TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 14,
          ),
        ),
        largeTitle: Center(
          child: GlowText(
            largeTitleText ?? middleText,
            style: TextStyle(
                fontFamily: GoogleFonts.averiaSerifLibre().fontFamily,
                fontWeight: FontWeight.w900,
                fontSize: 45,
                color: const Color.fromRGBO(247, 223, 208, 1.0)),
            glowColor:
                CupertinoColors.systemYellow.elevatedColor.withOpacity(.5),
            blurRadius: 10,
          ),
        ),
      );
}
