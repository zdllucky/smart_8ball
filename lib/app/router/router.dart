import 'package:go_router/go_router.dart';
import 'package:smart_8ball/infrastructure/di/injections.dart';

import '../alert/__.dart';
import '../auth/__.dart';
import '../ball/__.dart';
import '../profile/__.dart';
import '../sign_in/__.dart';
import '../sign_up/__.dart';
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
