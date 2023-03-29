import 'package:flutter/cupertino.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_8ball/app/shared/widgets/dark_blue_c_p_scaffold.dart';
import 'package:smart_8ball/app/sign_up/widgets/sign_up_form.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) => DarkBlueCPScaffold(
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            CupertinoSliverNavigationBar(
              automaticallyImplyLeading: true,
              automaticallyImplyTitle: true,
              previousPageTitle: "Back",
              alwaysShowMiddle: false,
              stretch: true,
              backgroundColor: const Color(0x00000000),
              largeTitle: GlowText(
                'Sign up',
                style: TextStyle(
                    fontFamily: GoogleFonts.averiaSerifLibre().fontFamily,
                    color: const Color.fromRGBO(247, 223, 208, 1.0)),
                glowColor:
                    CupertinoColors.systemYellow.elevatedColor.withOpacity(.5),
                blurRadius: 10,
              ),
            ),
            const SliverFillRemaining(
              hasScrollBody: false,
              child: SignUpForm(),
            )
          ],
        ),
      );
}
