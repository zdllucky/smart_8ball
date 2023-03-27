import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import 'ball/__.dart';
import 'profile/__.dart';
import 'sign_in/__.dart';
import 'sign_up/__.dart';

String? _authedRedirectFn(_, __) =>
    FirebaseAuth.instance.currentUser?.isAnonymous ?? false ? null : '/';

final appRouter = GoRouter(routes: [
  GoRoute(path: '/', redirect: (_, __) => '/ball'),
  GoRoute(path: '/ball', builder: (context, state) => const BallView()),
  GoRoute(
      path: '/sign-in',
      redirect: _authedRedirectFn,
      builder: (context, state) => const SignInView()),
  GoRoute(
      path: '/sign-up',
      redirect: _authedRedirectFn,
      builder: (context, state) => const SignUpView()),
  GoRoute(path: '/profile', builder: (context, state) => const ProfileView()),
]);
