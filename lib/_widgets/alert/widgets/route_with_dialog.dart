import 'package:go_router/go_router.dart';

import 'alert_provider.dart';

extension WithDialog on GoRoute {
  GoRoute withDialog() {
    return GoRoute(
      path: path,
      name: name,
      parentNavigatorKey: parentNavigatorKey,
      redirect: redirect,
      routes: routes,
      builder: (context, state) =>
          AlertProvider(child: builder!(context, state)),
    );
  }
}
