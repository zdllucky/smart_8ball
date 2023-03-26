import 'package:go_router/go_router.dart';

import 'ball/__.dart';
import 'profile/__.dart';
import 'sign_in/__.dart';
import 'sign_up/__.dart';

final appRouter = GoRouter(routes: [
  GoRoute(path: '/', redirect: (_, __) => '/ball'),
  GoRoute(path: '/ball', builder: (context, state) => const BallView()),
  GoRoute(path: '/sign-in', builder: (context, state) => const SignInView()),
  GoRoute(path: '/sign-up', builder: (context, state) => const SignUpView()),
  GoRoute(path: '/profile', builder: (context, state) => const ProfileView()),
]);
