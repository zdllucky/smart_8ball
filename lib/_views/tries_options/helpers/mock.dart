import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:smart_8ball/_support/auth/__.dart';
import 'package:smart_8ball/_support/functions/__.dart';

abstract class Mock {
  static Future<void> admobAddTryAdCallback(
    FunctionsService functionsService,
    AuthService authService,
    DeviceMetadataService deviceMetadataService,
    String adUnitId,
    RewardItem reward,
  ) async {
    final client = functionsService.createClient
      ..options.baseUrl = functionsService.baseUrl
      ..options.headers['user-agent'] = 'Google-AdMob-Reward-Verification';

    await client.get('v1/admob/adTryAdCallback/', queryParameters: {
      'ad_network': '5450213213286189855',
      'ad_unit': adUnitId,
      'custom_data': '{"deviceId": "${deviceMetadataService.deviceId}"}',
      'reward_amount': reward.amount,
      'reward_item': reward.type,
      'user_id': authService.user!.uid,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'transaction_id': '123456789',
      'signature':
          'MEQCIB8A3vRFXUiM-aoJuAC_HDx0BzS0t2FeixoPOv0R3meqAiBSXNkaB22JiIa4kuW2INd8HJgomgWUeZW3tBsF2BKq7w',
      'key_id': '3335741209',
    }).then((value) => null, onError: (err) {
      debugPrint('Error: ${(err as DioError).response?.data.toString()}');
    });
  }
}
