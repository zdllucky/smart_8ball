import 'package:injectable/injectable.dart';
import 'package:record/record.dart';
import 'package:smart_8ball/_support/record/services/player_service.dart';

import 'file_service.dart';

@lazySingleton
class RecordService {
  final _record = Record();
  final PlayerService _playerService;
  final FileService _fileService;
  String? _path;

  RecordService(this._playerService, this._fileService);

  String? get path => _path;

  Future<bool> get checkPermission async => await _record.hasPermission();

  Future<bool> get isRecording async => await _record.isRecording();

  Future<void> start({bool checkPermission = true}) async {
    if (checkPermission && !(await this.checkPermission)) return;

    if (_path != null) _fileService.deleteFile(_path!);

    await _record.start(encoder: AudioEncoder.wav);

    _path = null;
  }

  /// Stops recording and returns the path to the recorded audio file
  Future<String?> stop({bool cancel = false, bool playRecord = false}) async {
    if (!await _record.isRecording()) return null;

    if (!cancel) {
      _path = await _record.stop();

      if (playRecord) _playerService.playFromFile(_path);
    } else {
      final rec = await _record.stop();

      if (rec != null) {
        _fileService.deleteFile(rec);
      }
    }

    return _path;
  }
}
