import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_8ball/app/ball/widgets/ball_motion.dart';

class BallView extends StatelessWidget {
  const BallView({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color(0xff151421),
            Color(0xff151421),
            Color(0xff1D150F),
            Color(0xff22170C)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            CupertinoSliverNavigationBar(
              trailing: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => context.push('/profile'),
                  child: const Icon(
                    FluentIcons.person_48_regular,
                  )),
              backgroundColor: const Color(0x00000000),
              middle: const Text(
                'Ponder8',
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                ),
              ),
              alwaysShowMiddle: true,
              largeTitle: Center(
                child: GlowText(
                  'Mighty Ball  ',
                  style: TextStyle(
                      fontFamily: GoogleFonts.averiaSerifLibre().fontFamily,
                      fontWeight: FontWeight.w900,
                      fontSize: 45,
                      color: const Color.fromRGBO(247, 223, 208, 1.0)),
                  glowColor: CupertinoColors.systemYellow.elevatedColor
                      .withOpacity(.5),
                  blurRadius: 10,
                ),
              ),
            ),
            SliverFillRemaining(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    SizedBox(
                      height: 48,
                    ),
                    BallMotion()
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
