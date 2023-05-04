import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeviceMetadataService {
  String? _deviceId;

  String _generateRandomString(int length) {
    final random = Random.secure();
    final values = List<int>.generate(length, (i) => random.nextInt(256));
    return base64Url.encode(values).substring(0, length);
  }

  String _base64Hash(String input) {
    final bytes = utf8.encode(input); // Convert the input string to bytes
    final digest =
        sha256.convert(bytes); // Compute the hash (SHA-256 in this case)
    return base64
        .encode(digest.bytes); // Convert the hash to a base64-encoded string
  }

  String get deviceId => _deviceId!;

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    if (_deviceId != null) return;

    String? deviceId;
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = _base64Hash(androidInfo.fingerprint);
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId =
          _base64Hash(iosInfo.identifierForVendor ?? _generateRandomString(20));
    }

    _deviceId = deviceId ?? _generateRandomString(20);
  }
}
