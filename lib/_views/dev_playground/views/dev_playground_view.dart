import 'package:flutter/material.dart';

import '../../../_widgets/dark_blue_c_p_scaffold.dart';
import '../../../_widgets/themed_c_s_navigation_bar.dart';
import '../widgets/actions_test_section.dart';

class DevPlaygroundView extends StatelessWidget {
  const DevPlaygroundView({super.key});

  @override
  Widget build(BuildContext context) => const DarkBlueCPScaffold(
          child: CustomScrollView(slivers: [
        ThemedCSNavigationBar(
            middleText: 'Dev Playground', largeTitleCentered: false),
        SliverFillRemaining(hasScrollBody: false, child: ActionsTestSection())
      ]));
}
