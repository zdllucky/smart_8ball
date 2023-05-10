import 'package:audioplayers/audioplayers.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PlayerService {
  final _player = AudioPlayer();
  String? _path;

  Future<void> playFromFile(String? filePath) async {
    assert(filePath != null || _path != null, 'File path cannot be null');

    await _player.play(DeviceFileSource(filePath ?? _path!));
  }

  Future<void> stop() async {
    await _player.stop();
  }
}
