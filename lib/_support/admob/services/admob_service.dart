import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_8ball/_support/app_root/__.dart';

import '../consts/ad_identifiers.dart';

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
    bool isTest = Mode.isEmulator,
  }) async {
    final AnchoredAdaptiveBannerAdSize? size = await _getPossibleAdSize(width);
    if (size == null) return null;

    return BannerAd(
      adUnitId:
          AdIdentifiers.baseBanner.decide(Mode.isEmulator, Platform.isIOS),
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: onAdFailedToLoad,
      ),
    )..load();
  }

  Future<void> createAddTryAd(RewardedAdLoadCallback callback) async {
    await RewardedAd.load(
        adUnitId:
            AdIdentifiers.addTryAd.decide(Mode.isEmulator, Platform.isIOS),
        request: const AdRequest(),
        rewardedAdLoadCallback: callback);
  }
}

extension Ext on RewardedAd {
  Future<void> withCustomSSVOptions(User? user,
          {Map<String, dynamic>? options}) async =>
      await setServerSideOptions(ServerSideVerificationOptions(
        userId: user?.uid,
        customData: json.encode(options ?? {}),
      ));
}
