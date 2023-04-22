import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:injectable/injectable.dart';

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

  Future<BannerAd?> createBannerAd(double width,
      {void Function(Ad)? onAdLoaded,
      void Function(Ad, LoadAdError)? onAdFailedToLoad}) async {
    final AnchoredAdaptiveBannerAdSize? size = await _getPossibleAdSize(width);
    if (size == null) return null;

    return BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: onAdFailedToLoad,
      ),
    )..load();
  }
}
