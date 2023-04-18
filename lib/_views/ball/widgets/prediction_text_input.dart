import 'dart:ui';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:smart_8ball/_widgets/common/__.dart';

import '../logic/ball_action/ball_action_bloc.dart';

class PredictionTextInput extends StatefulWidget {
  const PredictionTextInput({super.key});

  @override
  State<PredictionTextInput> createState() => _PredictionTextInputState();
}

class _PredictionTextInputState extends State<PredictionTextInput>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormBuilderState>();
  // bool _isLoading = false;
  bool _canSubmit = false;
  late AnimationController _controller;
  late Animation<double> _blurAnimation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 260),
        reverseDuration: const Duration(milliseconds: 260));
    _blurAnimation = Tween<double>(begin: 3, end: 20).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut));
    _controller.forward(from: 0);

    _controller.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void validateFields() => setState(
      () => _canSubmit = _formKey.currentState?.saveAndValidate() ?? false);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: _blurAnimation.value, sigmaY: _blurAnimation.value),
          child: Container(
            padding: const EdgeInsets.all(4).copyWith(right: 6),
            decoration: BoxDecoration(
              color: CupertinoColors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: FBuilderCTField(
                    name: 'question',
                    placeholder: 'Type your question here...',
                    minLines: 3,
                    maxLines: 3,
                    autofocus: true,
                    unFocusOnSwipe: true,
                    decoration: BoxDecoration(color: Color(0x00000000)),
                  ),
                ),
                Row(children: [
                  RoundedCButton(
                    onPressed: () =>
                        context.read<BallActionBloc>().add(StopWriting()),
                    filled: false,
                    padding: const EdgeInsets.all(8),
                    minSize: 32,
                    icon: FluentIcons.dismiss_24_regular,
                  ),
                  Expanded(
                    child: RoundedCButton(
                      onPressed: _canSubmit || kDebugMode ? () {} : null,
                      padding: const EdgeInsets.all(8),
                      minSize: 32,
                      icon: FluentIcons.chat_help_24_regular,
                      text: 'Ask Ball...',
                    ),
                  )
                ])
              ],
            ),
          ),
        ),
      );
}
