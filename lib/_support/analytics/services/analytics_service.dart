import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';

@injectable
class AnalyticsService {
  FirebaseAnalytics get _provider => FirebaseAnalytics.instance;

  @FactoryMethod(preResolve: true)
  Future<void> init() async {
    _provider.setAnalyticsCollectionEnabled(true);
  }

  set user(String userId) => _provider.setUserId(id: userId);

  set userParams(Map<String, String> props) =>
      props.forEach((k, v) => _provider.setUserProperty(name: k, value: v));

  Future<void> Function({
    String? screenClass,
    String? screenName,
    AnalyticsCallOptions? callOptions,
  }) get logScreenView => _provider.logScreenView;
}
