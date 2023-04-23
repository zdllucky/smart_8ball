import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_8ball/_widgets/common/__.dart';

class TriesOptionsView extends StatelessWidget {
  const TriesOptionsView({super.key});

  @override
  Widget build(BuildContext context) => DarkBlueCPScaffold(
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            const ThemedCSNavigationBar(
              middleText: 'Redeem questions',
              largeTitleCentered: false,
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  RoundedCButton(
                    icon: FluentIcons.eye_20_regular,
                    text: 'Watch ad',
                    onPressed: () {},
                  )
                ]),
              ),
            )
          ],
        ),
      );
}
