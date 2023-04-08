import 'package:flutter/cupertino.dart';
import 'package:smart_8ball/_widgets/common/__.dart';

import '../widgets/sign_in_form.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) => const DarkBlueCPScaffold(
        child: CustomScrollView(
          slivers: [
            ThemedCSNavigationBar(
                middleText: 'Sign in', largeTitleCentered: false),
            SliverFillRemaining(hasScrollBody: false, child: SignInForm()),
          ],
        ),
      );
}
