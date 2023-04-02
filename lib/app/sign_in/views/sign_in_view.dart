import 'package:flutter/cupertino.dart';

import '../../shared/widgets/dark_blue_c_p_scaffold.dart';
import '../../shared/widgets/themed_c_s_navigation_bar.dart';
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
