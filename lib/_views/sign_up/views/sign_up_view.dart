import 'package:flutter/cupertino.dart';
import 'package:smart_8ball/_widgets/common/__.dart';

import '../widgets/sign_up_form.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) => const DarkBlueCPScaffold(
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            ThemedCSNavigationBar(
                middleText: 'Sign up', largeTitleCentered: false),
            SliverFillRemaining(hasScrollBody: false, child: SignUpForm())
          ],
        ),
      );
}
