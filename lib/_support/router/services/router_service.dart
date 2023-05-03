import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_8ball/_support/analytics/__.dart';
import 'package:smart_8ball/_support/auth/__.dart';
import 'package:smart_8ball/_views/ball/views/ball_view.dart';
import 'package:smart_8ball/_views/dev_playground/__.dart';
import 'package:smart_8ball/_views/profile/__.dart';
import 'package:smart_8ball/_views/sign_in/__.dart';
import 'package:smart_8ball/_views/sign_up/__.dart';
import 'package:smart_8ball/_views/tries_options/__.dart';
import 'package:smart_8ball/_widgets/alert/__.dart';

import '../widgets/prev_page_redirect.dart';

class AnalyticsGoRouter extends GoRouter {
  final AnalyticsService _analyticsService;

  AnalyticsGoRouter({
    required List<RouteBase> routes,
    required AnalyticsService analyticsService,
  })  : _analyticsService = analyticsService,
        super(routes: routes) {
    addListener(_onRouteChanged);
  }

  void _onRouteChanged() {
    _analyticsService.logScreenView(screenName: location);
  }

  @override
  void dispose() {
    removeListener(_onRouteChanged);
    super.dispose();
  }
}

// TODO: Provide isolation for router via named getit
@lazySingleton
class RouterService {
  final AuthService _authService;
  final AnalyticsService _analyticsService;
  late final GoRouter router;

  RouterService(
    this._authService,
    this._analyticsService,
  ) {
    router = AnalyticsGoRouter(
      analyticsService: _analyticsService,
      routes: [
        GoRoute(
          path: '/',
          redirect: (_, __) => '/ball',
        ),
        GoRoute(
          path: '/ball',
          builder: (context, state) => BallView(),
        ).withDialog(),
        GoRoute(
          path: '/dev-playground',
          builder: (context, state) => const DevPlaygroundView(),
        ),
        GoRoute(
          path: '/sign-in',
          builder: (context, state) => PrevPageRedirect(
            predicate: _authedRedirectPredicate,
            child: const SignInView(),
          ),
        ),
        GoRoute(
          path: '/sign-up',
          builder: (context, state) => PrevPageRedirect(
            predicate: _authedRedirectPredicate,
            child: const SignUpView(),
          ),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileView(),
        ),
        GoRoute(
          path: '/tries-options',
          builder: (context, state) => PrevPageRedirect(
            predicate: _authedRedirectPredicate,
            child: const TriesOptionsView(),
          ),
        ),
      ],
    );
  }

  bool _authedRedirectPredicate() =>
      !(_authService.provider.currentUser?.isAnonymous ?? false);
}
