import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_8ball/_support/di/__.dart';
import 'package:smart_8ball/_widgets/alert/__.dart';
import 'package:smart_8ball/_widgets/common/__.dart';

class ProfileSettingsBlock extends StatelessWidget {
  const ProfileSettingsBlock({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(32),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (user.email != null)
                Text(
                  user.email!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: GoogleFonts.averiaSerifLibre().fontFamily,
                      color: const Color(0xffD4C6BD),
                      letterSpacing: .3),
                ),
              if (user.email != null && !user.emailVerified)
                RoundedCButton(
                  filled: false,
                  padding: const EdgeInsets.only(left: 8),
                  text: 'Verify email',
                  onPressed: () => _verifyEmail(context),
                ),
            ],
          ),
        ),
      ],
    );
  }

  void _verifyEmail(BuildContext context) {
    user.sendEmailVerification();
    get<AlertCubit>().showAlertDialog(BasicAlert(
      alert: const Text('Email verification sent'),
      content: const Text('Please check your email and verify your account.'),
    ));
  }
}
