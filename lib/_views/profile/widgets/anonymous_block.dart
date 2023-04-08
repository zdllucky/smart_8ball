import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../_widgets/rounded_c_button.dart';

class AnonymousBlock extends StatelessWidget {
  const AnonymousBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Text(
              'Sign up or sign in \nto upgrade your account \nand get even more \ntokens and features!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: GoogleFonts.averiaSerifLibre().fontFamily,
                  color: const Color(0xffD4C6BD),
                  letterSpacing: .3),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(32),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              RoundedCButton(
                  filled: false,
                  icon: FluentIcons.arrow_enter_20_regular,
                  text: 'Sign in',
                  onPressed:
                      FirebaseRemoteConfig.instance.getBool('signInEnabled')
                          ? () => context.push('/sign-in')
                          : null),
              RoundedCButton(
                  icon: FluentIcons.person_add_20_regular,
                  text: 'Sign up',
                  onPressed:
                      FirebaseRemoteConfig.instance.getBool('signUpEnabled')
                          ? () => context.push('/sign-up')
                          : null),
            ],
          ),
        )
      ],
    );
  }
}
