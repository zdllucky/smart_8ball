import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_8ball/_widgets/tries/__.dart';

import '../../../_widgets/ball/__.dart';
import '../logic/ball_action/ball_action_bloc.dart';
import '../widgets/page_scaffold.dart';
import '../widgets/prediction_text_input.dart';

class BallView extends StatelessWidget {
  final GlobalKey _ballKey = GlobalKey();

  BallView({super.key});

  @override
  Widget build(BuildContext context) => PageScaffold(
        child: BlocBuilder<BallActionBloc, BallActionState>(
          builder: (context, state) =>
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            const SizedBox(height: 48),
            AnimatedSize(
                alignment: Alignment.center,
                curve: Curves.easeIn,
                duration: const Duration(milliseconds: 70),
                reverseDuration: const Duration(milliseconds: 360),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: SizedBox(
                  width: state is BallActionWriting ? 100 : null,
                  height: state is BallActionWriting ? 100 : null,
                  child: BallMotion(key: _ballKey),
                )),
            const SizedBox(height: 32),
            AnimatedSwitcher(
                duration: const Duration(milliseconds: 420),
                switchInCurve: Curves.easeOutBack,
                switchOutCurve: Curves.easeInOut,
                layoutBuilder: (currentChild, previousChildren) => Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          ...previousChildren,
                          if (currentChild != null) currentChild
                        ]),
                reverseDuration: const Duration(milliseconds: 520),
                transitionBuilder: (child, animation) => FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(scale: animation, child: child),
                    ),
                child: (state.isOneOf([BallActionWriting]))
                    ? const PredictionTextInput()
                    : const BallTries())
          ]),
        ),
      );
}
