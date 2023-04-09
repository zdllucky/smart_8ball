import 'package:flutter/cupertino.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemedCSNavigationBar extends StatefulWidget {
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

  @override
  State<ThemedCSNavigationBar> createState() => _ThemedCSNavigationBarState();
}

class _ThemedCSNavigationBarState extends State<ThemedCSNavigationBar> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  Widget ifCenteredChild(Widget child) =>
      widget.largeTitleCentered ? Center(child: child) : child;

  @override
  Widget build(BuildContext context) => CupertinoSliverNavigationBar(
        key: widget.key,
        automaticallyImplyLeading:
            widget.automaticallyImplyLeading && widget.leading == null,
        leading: widget.leading,
        trailing: widget.trailing,
        previousPageTitle: widget.previousPageTitle,
        stretch: true,
        backgroundColor: const Color(0x00000000),
        automaticallyImplyTitle: widget.largeTitleText == null,
        alwaysShowMiddle: widget.largeTitleText != null,
        middle: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
          child: Text(
            widget.middleText,
            style: const TextStyle(
              fontWeight: FontWeight.w100,
            ),
          ),
        ),
        largeTitle: ifCenteredChild(
          Transform.scale(
            scaleX: 1.05,
            child: GlowText(
              widget.largeTitleText ?? widget.middleText,
              style: TextStyle(
                  fontFamily: GoogleFonts.averiaSerifLibre().fontFamily,
                  fontWeight:
                      widget.largeTitleCentered ? FontWeight.w900 : null,
                  fontSize: widget.largeTitleCentered ? 45 : null,
                  color: const Color.fromRGBO(247, 223, 208, 1.0)),
              glowColor:
                  CupertinoColors.systemYellow.elevatedColor.withOpacity(.5),
              blurRadius: 10,
            ),
          ),
        ),
      );
}
