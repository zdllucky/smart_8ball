import 'package:go_router/go_router.dart';

import '../../../../_support/di/injections.dart';
import '../../_views/ball/__.dart';
import '../../_views/dev_playground/__.dart';
import '../../_views/profile/__.dart';
import '../../_views/sign_in/__.dart';
import '../../_views/sign_up/__.dart';
import '../../_widgets/alert/__.dart';
import '../auth/__.dart';
import 'widgets/prev_page_redirect.dart';

bool _authedRedirectPredicate() =>
    !(get<AuthService>().provider.currentUser?.isAnonymous ?? false);

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      redirect: (_, __) => '/ball',
    ),
    GoRoute(path: '/ball', builder: (context, state) => const BallView())
        .withDialog(),
    GoRoute(
      path: '/sign-in',
      builder: (context, state) => const PrevPageRedirect(
        predicate: _authedRedirectPredicate,
        child: SignInView(),
      ),
    ),
    GoRoute(
      path: '/sign-up',
      builder: (context, state) => const PrevPageRedirect(
          predicate: _authedRedirectPredicate, child: SignUpView()),
    ),
    GoRoute(path: '/profile', builder: (context, state) => const ProfileView()),
  ],
);
