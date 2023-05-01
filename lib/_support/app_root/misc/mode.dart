class Mode {
  const Mode() : _value = _fromEnvironment;
  const Mode._(String value) : _value = value;

  final String _value;

  static const String _fromEnvironment =
      String.fromEnvironment('FIREBASE_ENV', defaultValue: 'emulator');

  static const Mode emulator = Mode._('emulator');
  static const Mode cloud = Mode._('cloud');

  @override
  String toString() => _value;

  static const bool isEmulator = _fromEnvironment == 'emulator';
}
