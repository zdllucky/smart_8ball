class AdIdentifiers {
  static const AdIdentifier baseBanner = AdIdentifier(
    test: AdIdentifierPair(
      ios: 'ca-app-pub-3940256099942544/2934735716',
      android: 'ca-app-pub-3940256099942544/6300978111',
    ),
    prod: AdIdentifierPair.common('ca-app-pub-2556123726417262/5996692787'),
  );

  static const AdIdentifier addTryAd = AdIdentifier(
    test: AdIdentifierPair(
      ios: 'ca-app-pub-3940256099942544/1712485313',
      android: 'ca-app-pub-3940256099942544/5224354917',
    ),
    prod: AdIdentifierPair.common('ca-app-pub-2556123726417262/8510055928'),
  );
}

class AdIdentifier {
  final AdIdentifierPair test;
  final AdIdentifierPair prod;

  const AdIdentifier({
    this.test = const AdIdentifierPair(),
    this.prod = const AdIdentifierPair(),
  });

  String decide(bool isTest, bool isIOS) => isTest
      ? (isIOS ? test._ios : test._android)
      : (isIOS ? prod._ios : prod._android);
}

class AdIdentifierPair {
  final String _ios;
  final String _android;

  const AdIdentifierPair({
    String ios = '',
    String android = '',
  })  : _android = android,
        _ios = ios;

  const AdIdentifierPair.common(common)
      : _ios = common,
        _android = common;
}
