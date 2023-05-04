import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:smart_8ball/_support/admob/__.dart';
import 'package:smart_8ball/_support/app_root/__.dart';
import 'package:smart_8ball/_support/auth/__.dart';
import 'package:smart_8ball/_support/di/__.dart';
import 'package:smart_8ball/_support/functions/__.dart';
import 'package:smart_8ball/_widgets/alert/__.dart';
import 'package:smart_8ball/_widgets/common/__.dart';

import '../helpers/mock.dart';

class Redeem extends StatelessWidget {
  const Redeem(
    this._admobService,
    this._authService,
    this._alertCubit,
    this._functionsService,
    this._deviceMetadataService, {
    super.key,
    void Function(bool)? adLoading,
  }) : _adLoading = adLoading;

  final AdmobService _admobService;
  final AlertCubit _alertCubit;
  final AuthService _authService;
  final FunctionsService _functionsService;
  final DeviceMetadataService _deviceMetadataService;
  final void Function(bool)? _adLoading;

  void _adLoadingSafe(loading) {
    if (_adLoading != null) _adLoading!(loading);
  }

  void _loadAd(void Function(RewardedAd) onAdLoaded) async {
    _adLoadingSafe(true);
    await _admobService.createAddTryAd(RewardedAdLoadCallback(
      onAdLoaded: onAdLoaded,
      onAdFailedToLoad: (LoadAdError error) {
        get<AlertCubit>().showAlertDialog(BasicAlert(
          alert: const Text('Oops...'),
          content: Text(error.message),
        ));

        _adLoadingSafe(false);
      },
    ));
  }

  Future<void> _showAd(RewardedAd ad) async {
    await ad.withCustomSSVOptions(
      _authService.user,
      options: {"deviceId": _deviceMetadataService.deviceId},
    );

    ad
      ..fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) => _adLoadingSafe(false),
        onAdImpression: (ad) => _adLoadingSafe(false),
        onAdFailedToShowFullScreenContent: (ad, err) {
          _adLoadingSafe(false);
          _alertCubit.showAlertDialog(BasicAlert(
            alert: const Text('Oops...'),
            content: Text(err.message),
          ));
          ad.dispose();
        },
        onAdDismissedFullScreenContent: (ad) => ad.dispose(),
      )
      ..show(onUserEarnedReward: (ad, reward) {
        debugPrint('User earned reward of ${reward.amount} ${reward.type}');
        if (Mode.isEmulator) {
          Mock.admobAddTryAdCallback(
            _functionsService,
            _authService,
            _deviceMetadataService,
            ad.adUnitId,
            reward,
          );
        }
        _alertCubit.showAlertDialog(BasicAlert(
          alert: const Text('Success!'),
          content: const Text('You now have +1 more questions to ask!'),
        ));
        ad.dispose();
      });
  }

  @override
  Widget build(BuildContext context) {
    return RoundedCButton(
      icon: FluentIcons.eye_20_regular,
      text: 'Watch ad to get one',
      onPressed: () => _loadAd(_showAd),
    );
  }
}
