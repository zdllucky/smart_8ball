import 'package:flutter/material.dart';
import 'package:smart_8ball/_widgets/common/__.dart';

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
