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
      this.leading,
      this.largeTitleCentered = true});
  final String previousPageTitle;
  final String middleText;
  final String? largeTitleText;
  final bool automaticallyImplyLeading;
  final Widget? trailing;
  final Widget? leading;
  final bool largeTitleCentered;

  Widget ifCenteredChild(Widget child) =>
      largeTitleCentered ? Center(child: child) : child;

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
            fontWeight: FontWeight.w100,
          ),
        ),
        largeTitle: ifCenteredChild(
          GlowText(
            largeTitleText ?? middleText,
            style: TextStyle(
                fontFamily: GoogleFonts.averiaSerifLibre().fontFamily,
                fontWeight: largeTitleCentered ? FontWeight.w900 : null,
                fontSize: largeTitleCentered ? 45 : null,
                color: const Color.fromRGBO(247, 223, 208, 1.0)),
            glowColor:
                CupertinoColors.systemYellow.elevatedColor.withOpacity(.5),
            blurRadius: 10,
          ),
        ),
      );
}
