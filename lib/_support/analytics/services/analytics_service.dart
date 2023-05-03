import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AnalyticsService {
  FirebaseAnalytics get _provider => FirebaseAnalytics.instance;
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    await _provider.setAnalyticsCollectionEnabled(true);
  }

  set user(String userId) => _provider.setUserId(id: userId);

  set userParams(Map<String, String> props) =>
      props.forEach((k, v) => _provider.setUserProperty(name: k, value: v));

  Future<void> Function({
    String? screenClass,
    String? screenName,
    AnalyticsCallOptions? callOptions,
  }) get logScreenView => _provider.logScreenView;

  Future<void> Function() get logAppOpen => _provider.logAppOpen;
}
