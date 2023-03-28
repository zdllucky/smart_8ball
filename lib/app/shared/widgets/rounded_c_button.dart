import 'dart:async';

import 'package:flutter/cupertino.dart';

class RoundedCButton extends StatelessWidget {
  const RoundedCButton(
      {super.key,
      this.filled = true,
      // TODO: Decide if this should be set or not
      this.padding = const EdgeInsets.symmetric(horizontal: 32),
      this.onPressed,
      this.child,
      this.text,
      this.icon})
      : assert((text != null || icon != null) && child == null),
        assert(child != null || text != null || icon != null);
  final bool filled;
  final EdgeInsetsGeometry? padding;
  final FutureOr<void> Function()? onPressed;
  final Widget? child;
  final String? text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return filled
        ? CupertinoButton.filled(
            borderRadius: BorderRadius.circular(10e3),
            padding: padding,
            onPressed: onPressed,
            child: child ??
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) Icon(icon),
                    if (icon != null && text != null) const SizedBox(width: 4),
                    if (text != null) Text(text!),
                  ],
                ))
        : CupertinoButton(
            borderRadius: BorderRadius.circular(10e3),
            padding: padding,
            onPressed: onPressed,
            child: child ??
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) Icon(icon),
                    if (icon != null && text != null) const SizedBox(width: 4),
                    if (text != null) Text(text!),
                  ],
                ));
  }
}
