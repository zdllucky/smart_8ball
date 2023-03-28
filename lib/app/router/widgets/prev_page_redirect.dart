import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PrevPageRedirect extends StatelessWidget {
  const PrevPageRedirect(
      {super.key, required this.predicate, required this.child});
  final bool Function() predicate;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (predicate()) context.pop();
    return child;
  }
}
