library router;

import 'src/other.dart';
import 'package:injectable/injectable.dart';

export 'src/other.dart' show Damir;

@InjectableInit.microPackage()
initMicroPackage() {}

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
  final t = Damir();
}
