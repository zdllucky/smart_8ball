import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

@lazySingleton
class FileService {
  Future<bool> get checkPermission async {
    PermissionStatus status = await Permission.storage.status;

    if (status.isDenied || status.isPermanentlyDenied || status.isRestricted) {
      PermissionStatus newStatus = await Permission.storage.request();

      if (newStatus.isGranted) {
        return true;
      } else {
        return false;
      }
    }

    return true;
  }

  Future<bool> deleteFile(String path, {bool checkPermission = true}) async {
    if (checkPermission && !(await this.checkPermission)) return false;

    final file = File(path);

    if (file.existsSync()) {
      file.deleteSync();

      return !file.existsSync();
    }

    return false;
  }
}
