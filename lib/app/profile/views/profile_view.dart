import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  User? _user;
  late StreamSubscription<User?> _userListener;

  @override
  void initState() {
    _userListener = FirebaseAuth.instance
        .userChanges()
        .listen((u) => setState(() => _user = u));
    super.initState();
  }

  @override
  Future<void> dispose() async {
    await _userListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color(0xff161A24),
            Color(0xff0f0f1c),
            Color(0xff0d0d0e),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              automaticallyImplyLeading: true,
              previousPageTitle: "Back",
              stretch: true,
              backgroundColor: const Color(0x00000000),
              middle: const Text(
                'Welcome back,',
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                ),
              ),
              largeTitle: Center(
                child: GlowText(
                  '${_user!.isAnonymous ? 'Anonymous' : _user!.displayName ?? "Neal Oliver"}  ',
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
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Center(
                      child: Text(
                        'Sign up or sign in \nto upgrade your account \nand get even more \ntokens and features!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily:
                                GoogleFonts.averiaSerifLibre().fontFamily,
                            color: const Color(0xffD4C6BD),
                            letterSpacing: .3),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CupertinoButton(
                            borderRadius: BorderRadius.circular(100),
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(FluentIcons.arrow_enter_20_regular),
                                SizedBox(width: 4),
                                Text('Sign in'),
                              ],
                            ),
                            onPressed: () => context.push('/sign-in')),
                        CupertinoButton.filled(
                            borderRadius: BorderRadius.circular(100),
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            onPressed: () => context.push('/sign-up'),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(FluentIcons.person_add_20_regular),
                                SizedBox(width: 4),
                                Text('Sign up'),
                              ],
                            )),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}