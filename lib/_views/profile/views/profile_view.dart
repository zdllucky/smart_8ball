import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_8ball/_support/auth/__.dart';
import 'package:smart_8ball/_support/di/__.dart';
import 'package:smart_8ball/_widgets/common/__.dart';

import '../widgets/anonymous_block.dart';
import '../widgets/profile_settings_block.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) => DarkBlueCPScaffold(
        child: BlocBuilder<AuthCubit, User?>(
          builder: (context, user) {
            final isAnonymous = user?.isAnonymous ?? true;

            return CustomScrollView(
              slivers: [
                ThemedCSNavigationBar(
                  middleText: 'Welcome back,',
                  trailing: !isAnonymous
                      ? CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: const Icon(FluentIcons.arrow_exit_20_filled),
                          onPressed: () {
                            get<AuthService>().signInAnonymously();
                          },
                        )
                      : null,
                  largeTitleText:
                      '${isAnonymous ? 'Anonymous' : user!.displayName ?? "Neal Oliver"}  ',
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: isAnonymous
                      ? const AnonymousBlock()
                      : ProfileSettingsBlock(user: user!),
                )
              ],
            );
          },
        ),
      );
}
