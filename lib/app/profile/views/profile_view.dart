import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_8ball/app/shared/widgets/dark_blue_c_p_scaffold.dart';

import '../../shared/widgets/themed_c_s_navigation_bar.dart';
import '../widgets/anonymous_block.dart';

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
    return DarkBlueCPScaffold(
      child: CustomScrollView(
        slivers: [
          ThemedCSNavigationBar(
            middleText: 'Welcome back,',
            trailing: !_user!.isAnonymous
                ? CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Icon(FluentIcons.arrow_exit_20_filled),
                    onPressed: () async {
                      await FirebaseAuth.instance.signInAnonymously();
                    },
                  )
                : null,
            largeTitleText:
                '${_user!.isAnonymous ? 'Anonymous' : _user!.displayName ?? "Neal Oliver"}  ',
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: _user!.isAnonymous ? const AnonymousBlock() : null,
          )
        ],
      ),
    );
  }
}
