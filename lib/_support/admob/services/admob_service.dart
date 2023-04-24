import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_8ball/_support/admob/consts/ad_identifiers.dart';

@lazySingleton
class AdmobService {
  MobileAds get provider => MobileAds.instance;

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    await provider.initialize();
  }

  Future<AnchoredAdaptiveBannerAdSize?> _getPossibleAdSize(
          double width) async =>
      await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
          width.truncate());

  Future<BannerAd?> createBannerAd(
    double width, {
    void Function(Ad)? onAdLoaded,
    void Function(Ad, LoadAdError)? onAdFailedToLoad,
    bool isTest = kDebugMode,
  }) async {
    final AnchoredAdaptiveBannerAdSize? size = await _getPossibleAdSize(width);
    if (size == null) return null;

    return BannerAd(
      adUnitId: AdIdentifiers.baseBanner.decide(kDebugMode, Platform.isIOS),
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: onAdFailedToLoad,
      ),
    )..load();
  }

  Future<void> createAddTryAd(RewardedAdLoadCallback callback) async {
    late RewardedAd rewardedAd;

    await RewardedAd.load(
        adUnitId: AdIdentifiers.addTryAd.decide(kDebugMode, Platform.isIOS),
        request: const AdRequest(),
        rewardedAdLoadCallback: callback);
  }
}
