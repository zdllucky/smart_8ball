import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_8ball/_support/di/__.dart';
import 'package:smart_8ball/_widgets/common/__.dart';
import 'package:smart_8ball/_widgets/tries/__.dart';

import '../logic/ball_action/ball_action_bloc.dart';
import '../widgets/ball/ball_motion.dart';
import '../widgets/ball/prediction_text_input.dart';

class BallView extends StatelessWidget {
  const BallView({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<BallActionBloc>(
        create: (context) => get(),
        child: BlocBuilder<BallActionBloc, BallActionState>(
          builder: (context, state) => CupertinoPageScaffold(
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Color(0xff151421),
                  Color(0xff151421),
                  Color(0xff1D150F),
                  Color(0xff22170C)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
              child: CustomScrollView(
                physics: const NeverScrollableScrollPhysics(),
                slivers: [
                  ThemedCSNavigationBar(
                    middleText: 'Ponder8',
                    largeTitleText: 'Mighty Ball  ',
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: null,
                            child: Icon(FluentIcons.reading_list_24_regular)),
                        if (kDebugMode)
                          CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () => context.push('/dev-playground'),
                              child: const Icon(FluentIcons.code_24_regular)),
                      ],
                    ),
                    trailing: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => context.push('/profile'),
                        child: const Icon(
                          FluentIcons.person_48_regular,
                        )),
                  ),
                  SliverFillRemaining(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 48),
                          const BallMotion(),
                          const SizedBox(height: 32),
                          AnimatedSwitcher(
                              duration: const Duration(milliseconds: 420),
                              switchInCurve: Curves.easeOutBack,
                              switchOutCurve: Curves.easeInOut,
                              layoutBuilder: (currentChild, previousChildren) =>
                                  Stack(
                                      alignment: Alignment.topCenter,
                                      children: [
                                        ...previousChildren,
                                        if (currentChild != null) currentChild
                                      ]),
                              reverseDuration:
                                  const Duration(milliseconds: 520),
                              transitionBuilder: (child, animation) =>
                                  FadeTransition(
                                    opacity: animation,
                                    child: ScaleTransition(
                                        scale: animation, child: child),
                                  ),
                              child: (state is BallActionWriting ||
                                      state is BallActionSubmittingText)
                                  ? const PredictionTextInput()
                                  : const BallTries())
                        ]),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
