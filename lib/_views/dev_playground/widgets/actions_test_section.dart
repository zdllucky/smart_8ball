import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:smart_8ball/_widgets/common/__.dart';

class ActionsTestSection extends StatelessWidget {
  const ActionsTestSection({super.key});

  @override
  Widget build(BuildContext context) => Column(children: [
        RoundedCButton(
          text: 'Fire authed cloud function',
          filled: false,
          onPressed: () => FirebaseFunctions.instance
              .httpsCallable('/app/v1/ball/acquireDaily')
              .call()
              .then((value) => print(value.data))
              .onError((error, stackTrace) => print(error)),
        ),
      ]);
}
