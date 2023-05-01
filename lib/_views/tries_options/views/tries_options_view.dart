import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:smart_8ball/_support/di/__.dart';
import 'package:smart_8ball/_widgets/common/__.dart';

import '../widgets/redeem.dart';

class TriesOptionsView extends StatefulWidget {
  const TriesOptionsView({super.key});

  @override
  State<TriesOptionsView> createState() => _TriesOptionsViewState();
}

class _TriesOptionsViewState extends State<TriesOptionsView> {
  bool blurScreen = false;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          DarkBlueCPScaffold(
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                const ThemedCSNavigationBar(
                  middleText: 'Redeem questions',
                  largeTitleCentered: false,
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.all(16).copyWith(top: 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Redeem(
                          get(),
                          get(),
                          get(),
                          get(),
                          adLoading: (bool loading) =>
                              setState(() => blurScreen = loading),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned.fill(
              child: AbsorbPointer(
            absorbing: blurScreen,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: blurScreen
                  ? BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: const SizedBox())
                  : null,
            ),
          ))
        ],
      );
}
