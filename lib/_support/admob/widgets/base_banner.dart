import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:smart_8ball/_support/admob/services/admob_service.dart';

class BaseBanner extends StatefulWidget {
  final double height;

  const BaseBanner(
      {super.key,
      required this.width,
      this.padding,
      required this.admobService,
      required this.height});

  final double width;
  final EdgeInsets? padding;
  final AdmobService admobService;

  @override
  State<BaseBanner> createState() => _BaseBannerState();
}

class _BaseBannerState extends State<BaseBanner> with TickerProviderStateMixin {
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      reverseDuration: const Duration(milliseconds: 1000),
    );
    super.initState();
    Future.delayed(const Duration(milliseconds: 0), () {
      _controller
        ..forward(from: 0)
        ..addListener(() {
          setState(() {});
        });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('Loading anchored adaptive banner');
    _loadAd();
  }

  @override
  void dispose() {
    _controller.dispose();
    _anchoredAdaptiveAd?.dispose();
    super.dispose();
  }

  Future<void> _loadAd() async {
    // TODO: Add android ad unit id here when Android app is ready
    _anchoredAdaptiveAd = await widget.admobService.createBannerAd(widget.width,
        onAdLoaded: (Ad ad) {
      setState(() {
        _anchoredAdaptiveAd = ad as BannerAd;
        _isLoaded = true;
      });
    }, onAdFailedToLoad: (Ad ad, LoadAdError error) {
      debugPrint('Anchored adaptive banner failedToLoad: $error');
      ad.dispose();
    });
  }

  @override
  Widget build(BuildContext context) => Opacity(
        opacity: _controller.value,
        child: _isLoaded
            ? Container(
                alignment: Alignment.bottomCenter,
                padding: widget.padding,
                height: widget.height,
                width: _anchoredAdaptiveAd!.size.width.toDouble(),
                decoration: const BoxDecoration(
                  color: CupertinoColors.white,
                ),
                child: AdWidget(ad: _anchoredAdaptiveAd!),
              )
            : null,
      );
}
