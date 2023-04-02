import 'package:flutter/cupertino.dart';

import '../../shared/widgets/dark_blue_c_p_scaffold.dart';
import '../../shared/widgets/themed_c_s_navigation_bar.dart';
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
