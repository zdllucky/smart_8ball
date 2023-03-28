import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

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
        .listen((u) => setState(() => print(_user = u)));
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
            ThemedCSNavigationBar(
              middleText: 'Welcome back,',
              largeTitleText:
                  '${_user!.isAnonymous ? 'Anonymous' : _user!.displayName ?? "Neal Oliver"}  ',
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: _user!.isAnonymous ? const AnonymousBlock() : null,
            )
          ],
        ),
      ),
    );
  }
}
