import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import '../../../_widgets/themed_c_s_navigation_bar.dart';
import '../../../_widgets/tries/__.dart';
import '../widgets/ball/ball_motion.dart';

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
            ThemedCSNavigationBar(
              middleText: 'Ponder8',
              largeTitleText: 'Mighty Ball  ',
              trailing: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => context.push('/profile'),
                  child: const Icon(
                    FluentIcons.person_48_regular,
                  )),
            ),
            SliverFillRemaining(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [SizedBox(height: 48), BallMotion()]),
            )
          ],
        ),
      ),
    );
  }
}
