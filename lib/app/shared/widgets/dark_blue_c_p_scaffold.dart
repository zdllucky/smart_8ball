import 'package:flutter/cupertino.dart';

class DarkBlueCPScaffold extends StatelessWidget {
  const DarkBlueCPScaffold({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color(0xff161A24),
                Color(0xff0f0f1c),
                Color(0xff0d0d0e),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
            child: child));
  }
}
